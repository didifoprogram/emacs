(define-module (my packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages tls)
  #:use-module (guix build-system trivial)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix download))

(define (linux-nonfree-urls version)
  "Return a list of URLs for Linux-Nonfree VERSION."
  (list (string-append
         "https://www.kernel.org/pub/linux/kernel/v4.x/"
         "linux-" version ".tar.xz")))

(define-public linux-nonfree
  (let* ((version "4.14.3"))
    (package
      (inherit linux-libre)
      (name "linux-nonfree")
      (version version)
      (source (origin
                (method url-fetch)
                (uri (linux-nonfree-urls version))
                (sha256
                 (base32
                  "0rh3r1ik9xwa3pl5rrqjjbknyc7xnam10jih7v5q5v33pd716a5n"))))
      (synopsis "Mainline Linux kernel, nonfree binary blobs included.")
      (description "Linux is a kernel.")
      (license license:gpl2)
      (home-page "http://kernel.org/"))))

;;; Forgive me Stallman for I have sinned.

(define-public radeon-firmware-non-free
  (package
    (name "radeon-firmware-non-free")
    (version "7d2c913dcd1be083350d97a8cb1eba24cfacbc8a")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
                    (commit version)))
              (sha256
               (base32
                "1xwzsfa4x43z6s3284hmwgpxbvr15gg89bdanhg7i2xcll4xspxp"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder (begin
                   (use-modules (guix build utils))
                   (let ((source (assoc-ref %build-inputs "source"))
                         (fw-dir (string-append %output "/lib/firmware/radeon/")))
                     (mkdir-p fw-dir)
                     (for-each (lambda (file)
                                 (copy-file file
                                            (string-append fw-dir "/"
                                                           (basename file))))
                               (find-files source
                                           (lambda (file stat)
                                             (string-contains file "radeon"))))
                     #t))))

    (home-page "")
    (synopsis "Non-free firmware for Radeon integrated chips")
    (description "Non-free firmware for Radeon integrated chips")
    ;; FIXME: What license?
    (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.radeon_firmware;hb=HEAD"))))

(define-public perf-nonfree
  (package
    (inherit perf)
    (name "perf-nonfree")
    (version (package-version linux-nonfree))
    (source (package-source linux-nonfree))
    (license (package-license linux-nonfree))))

(use-modules (gnu)
             (gnu system)
             (gnu services)
             (gnu services desktop)
             (gnu services mail)
             (guix store)
             (my packages)
             (gnu system nss))
(use-service-modules desktop)
(use-package-modules bootloaders certs suckless wm )

(operating-system
  (host-name "diego")
  (timezone "America/Sao_Paulo")
  (kernel linux-nonfree)
  (locale "en_US.utf8")

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (target "/boot/efi")))

  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (cons* (file-system
                         (device "my-root")
                         (title 'label)
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (uuid "076A-A203" 'fat))
                         (title 'uuid)
                         (mount-point "/boot/efi")
                         (type "vfat"))
                       %base-file-systems))

  (users (cons (user-account
                (name "diego")
                (comment "noob")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/diego"))
               %base-user-accounts))

  ;; Add a bunch of window managers; we can choose one at
  ;; the log-in screen with F1.
  (packages (cons* i3-wm i3status dmenu ;window managers
                   nss-certs                      ;for HTTPS access
                   %base-packages))
(firmware (cons* radeon-firmware-non-free
                
                   %base-firmware))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with Wicd, and more.
  (services %desktop-services)

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
