(provide 'customize-keymap)

(global-set-key [f1] 'shell);F1进入Shell
(global-set-key [f5] 'gdb);F5调试程序
(setq compile-command "make -f Makefile")
(global-set-key [f7] 'do-compile);F7编译文件
(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key [f10] 'split-window-vertically);F10分割窗口
(global-set-key [f11] 'delete-other-windows);F11 关闭其它窗口
(global-set-key [f12] 'my-fullscreen);F12 全屏
(global-set-key (kbd "C-,") 'backward-page);文件首
(global-set-key (kbd "C-.") 'forward-page);文件尾
