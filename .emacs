;插件路径
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.40")
(add-to-list 'load-path "~/.emacs.d/plugins/cscope-15.8a")
(load-file "/usr/share/emacs/site-lisp/xcscope.el")
(add-to-list 'load-path "~/.emacs.d/plugins/cedet-1.1")
(add-to-list 'load-path "~/.emacs.d/plugins/cedet-1.1/common")
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/plugins/tabbar-1.3")
;;(add-to-list 'load-path "~/.emacs.d/plugins/ibus-el-0.3.2")

;;set ibus-el
;;(require 'ibus)
;;(add-hook 'after-init-hook 'ibus-mode-on)

;字体设置
(require 'font-settings)

;解决emacs shell 乱码
(setq ansi-color-for-comint-mode t)
(customize-group 'ansi-colors)
(kill-this-buffer);关闭customize窗口


;自定义按键
(require 'customize-keymap)
(global-set-key [?\S- ] 'set-mark-command)

;普通设置
(setq inhibit-startup-message t);关闭起动时闪屏
(setq visible-bell t);关闭出错时的提示声
(setq make-backup-files nil);不产生备份文件
(setq default-major-mode 'text-mode);一打开就起用 text 模式
(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode nil);去掉那个大大的工具栏
(scroll-bar-mode nil);去掉滚动条
;(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format '("" buffer-file-name "@emacs" ));在标题栏显示buffer名称
(setq default-fill-column 80);默认显示 80列就换行 


;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)


;非交互式编译
(defun do-compile ()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (setq compilation-read-command nil)
  (compile compile-command)
  (setq compilation-read-command t))


;shell,gdb退出后，自动关闭该buffer
(add-hook 'shell-mode-hook 'mode-hook-func)
(add-hook 'gdb-mode-hook 'mode-hook-func)
(defun mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
         #'kill-buffer-on-exit))
(defun kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))


;全屏
;;(defun my-fullscreen ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;最大化
;;(defun my-maximized-horz ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
;;(defun my-maximized-vert ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
;;(defun my-maximized ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
;;(my-maximized)
;;; Nice size for the default window
(defun get-default-height ()
       (/ (- (display-pixel-height) 50)
          (frame-char-height)))
(defun get-default-width ()
       (/ (- (display-pixel-width) 35)
          (frame-char-width)))
(add-to-list 'default-frame-alist (cons 'width (get-default-width)))
(add-to-list 'default-frame-alist (cons 'height (get-default-height)))


;加入会话功能
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)
;;(load "desktop")
;;(desktop-save-mode)


;加入标签功能
(require 'tabbar)
(tabbar-mode)
;(global-set-key (kbd "") 'tabbar-backward-group)
;(global-set-key (kbd "") 'tabbar-forward-group)
(global-set-key (kbd "C-`") 'tabbar-backward)
(global-set-key (kbd "C-<tab>") 'tabbar-forward)
;设置tabbar字体
;;(set-face-attribute 'tabbar-default-face
;;          nil :family "Tahoma")


;加入color-theme插件
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(color-theme-xemacs)
;; 设置tabbar外观  
;; 设置默认主题: 字体, 背景和前景颜色，大小  
(set-face-attribute 'tabbar-default-face nil  
                    :family "DejaVu Sans Mono"  
                    :background "gray80"  
                    :foreground "gray30"  
                    :height 1.0  
                    )  
;; 设置左边按钮外观：外框框边大小和颜色  
(set-face-attribute 'tabbar-button-face nil  
                    :inherit 'tabbar-default  
                    :box '(:line-width 1 :color "yellow")  
                    )  
;; 设置当前tab外观：颜色，字体，外框大小和颜色  
(set-face-attribute 'tabbar-selected-face nil  
                    :inherit 'tabbar-default  
                    :foreground "DarkGreen"  
                    :background "LightGoldenrod"  
                    :box '(:line-width 2 :color "DarkGoldenrod")  
                    :overline "black"  
                    :weight 'bold  
                    )  
;; 设置非当前tab外观：外框大小和颜色  
(set-face-attribute 'tabbar-unselected-face nil  
                    :inherit 'tabbar-default  
                    :box '(:line-width 2 :color "#00B2BF")  
                    )


;启动最大化
;(require 'maxframe)
;(setq mf-max-width 1018)
;(setq mf-max-height 730)
;(add-hook 'window-setup-hook 'maximize-frame t)


;加入xcscope插件
(require 'xcscope)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;C/C++设定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;缩进策略
(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)))
;补全优先级
(autoload 'senator-try-expand-semantic "senator")
(setq hippie-expand-try-functions-list
      '(
   senator-try-expand-sematic
   try-expand-dabbrev
   try-expand-dabbrev-visible
   try-expand-dabbrev-all-buffers
   try-expand-dabbrev-from-kill
   try-complete-file-name-partially
   try-complete-file-name
   try-expand-all-abbrevs
   try-expand-list
   try-expand-line
   try-complete-lisp-symbol-partially
   try-complete-lisp-symbol))
;;;; CC-mode配置  http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
;;;;根据后缀判断所用的mode
;;;;注意：我在这里把.h关联到了c++-mode
(setq auto-mode-alist
      (append '(("\\.h$" . c++-mode)) auto-mode-alist))
;;;;我的C语言编辑策略
(defun my-c-mode-common-hook()
  (setq default-tab-width 4 indent-tabs-mode nil)
  (setq tab-width 4 indent-tabs-mode nil)
  (setq c-basic-offset 4)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  ;;按键定义
  ;(define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f7)] 'do-compile)
  ;(define-key c-mode-base-map [(f8)] 'ff-get-other-file)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)

  ;(define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;;;;我的C++语言编辑策略
(defun my-c++-mode-hook()
  (setq default-tab-width 4 indent-tabs-mode nil)
  (setq tab-width 4 indent-tabs-mode nil)
  (setq c-basic-offset 4)
  ;;(define-key c++-mode-map [f3] 'replace-regexp)
  (c-set-style "k&r"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)


;加入cedet插件
(add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
(require 'cedet)
(semantic-load-enable-code-helpers)
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(define-key-after (lookup-key global-map [menu-bar tools])
  [speedbar]
  '("Speedbar" .
    speedbar-frame-mode)
  [calendar])
(global-set-key [f4] 'speedbar);F4打开/关闭speedbar
;;;;semantic /usr/include      
(setq semanticdb-search-system-databases t)
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq semanticdb-project-system-databases
                  (list (semanticdb-create-database
          semanticdb-new-database-class
          "/usr/include")))))
;project root path
(setq semanticdb-project-roots 
      (list
       (expand-file-name "~/devel")))


;加入ecb插件
(require 'ecb)
;ecb设置
(require 'ecb-autoloads)
(setq stack-trace-on-error t)
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil
      inhibit-startup-message t
      ecb-auto-compatibility-check nil
      ecb-version-check nil) 



(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left8" (0.20967741935483872 . 0.27586206896551724) (0.20967741935483872 . 0.2413793103448276) (0.20967741935483872 . 0.27586206896551724) (0.20967741935483872 . 0.1724137931034483)))))
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;scroll other window
(global-set-key (kbd "C-c C-v") 'scroll-other-window)
(global-set-key (kbd "C-c C-b") 'scroll-other-window-down)

;shell
(setq shell-file-name "/bin/zsh")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
(global-set-key (kbd "C-c z") 'shell)
(global-set-key (kbd "<f10>") 'rename-buffer)

