" linux {{{
if g:islinux
    " 退出插入模式的时候自动进入英文状态，但是重新进入插入模式时会返回中文状态
    " Plug 'h-youhei/vim-fcitx'

    " 自己写的用于控制音乐切换的小插件 {{{
    Plug 'DaSea/SimpleMusicCtrl.vim'
    " SMCNext-下一首
    " SMCPlay-播放或暂停
    " SMCPrev-上一首
    " }}}

    " fcitx5设置输入法 {{{
    let s:get_fcitx_language_status = "fcitx5-remote"             " 获取当前输入法的状态值
    let s:set_fcitx_chinese         = "fcitx5-remote -o"          " 把输入法设置为 中文
    let s:set_fcitx_english         = "fcitx5-remote -c"          " 把输入法设置为 英文
    let g:saved_insert_mode_language_status = 1    " 初始设置 插入模式 输入法为英文
    " 当退出 插入模式 时,会把输入法设置为英文
    function! s:fcitx_2_english()
        let s:exit_insert_status = system(s:get_fcitx_language_status)      "检查退出 插入模式 时,输入法的状态
        if s:exit_insert_status != 1                         "如果退出 插入模式 时,输入法不是英文
            let l:temp = system(s:set_fcitx_english)                        "将输入法设置为英文
        endif
        let g:saved_insert_mode_language_status = s:exit_insert_status      "保存退出 插入模式 时的输入法状态 
    endfunction

    " 当进入 插入模式 时,输入法会自动选择语言为上一次插入模式使用的语言
    function! s:fcitx_enter_insert_mode()
        let s:enter_insert_status = system(s:get_fcitx_language_status)     "获取进入 插入模式 时,输入法的状态
        if s:enter_insert_status != g:saved_insert_mode_language_status     "如果当前输入法语言和上一次退出插入模式时的语言不一样
            if g:saved_insert_mode_language_status == 2     "改变输入法当前语言为上一次退出插入模式时的语言
                let l:temp = system(s:set_fcitx_chinese)
            else
                let l:temp = system(s:set_fcitx_english)
            endif
        endif
    endfunction

    "退出插入模式调用的函数
    autocmd InsertLeave * call s:fcitx_2_english()
    "进入插入模式调用的函数
    autocmd InsertEnter * call s:fcitx_enter_insert_mode()
    " }}}
endif
" }}}
"
" windows {{{
if g:iswindows
endif
" }}}

" vim:ts=4:sw=4:sts=4 et fdm=marker:
