#my own config
set print pretty on
set pagination off


define pnarr
     if $argc == 0
         help pnarr
     else
         set $size = $arg0.nelts
         set $capacity = $arg0.nalloc
         set $i = 0
        while $i < $size
            printf "elem[%d]: ", $i
             p *(($arg1*)($arg0.elts) + $i)
             set $i++
         end
        printf "Priority array size = %u\n", $size
         printf "Priority array capacity = %u\n", $capacity
     end
end

document pnarr
     Prints ngx_array_t information:all elements, size and capacity of the arr_var
     Syntax: pnarr arr_var elem_type
     Example:
         pnarr cycle->pathes ngx_path_t
end


define pnlist
     if $argc == 0
         help pnlist
     else
         set $size = $arg0.part.nelts
         set $capacity = $arg0.nalloc
         set $part = &($arg0.part)
         set $data = ($arg1*)($part->elts)
         set $i = 0
         set $continue = 1
         while $continue == 1
            if $i >= $part->nelts
                if $part->next == 0
                   set $continue = 0
                end

                if $continue
                    set $part = $part->next
                    set $data = ($arg1*)$part->elts
                    set $i = 0
                end
            end

            if $continue
                printf "elem[%d]: ", $i
                p *$data
                set $i++
            end
         end
         printf "frist list part's size = %u\n", $size
         printf "frist list part's capacity = %u\n", $capacity
     end
end

document pnlist
     Prints ngx_list_t information : all elements, size and capacity of the list_var
     Syntax: pnlist list_var elem_type
end

define pnmodule
    if $argc == 0
        help pnmodule
    else
        set $i = $arg0
        echo \n
        printf "-----------------module[%d]---------------------\n", $i
        p ngx_modules_name[$i]

        echo \nmodule's type :
        if ngx_modules[$i].type == 0x45524F43
            echo core_module
        end
        if ngx_modules[$i].type == 0x464E4F43
            echo conf_module
        end
        if ngx_modules[$i].type == 0x544E5645
            echo event_module
        end
        if ngx_modules[$i].type == 0x4C49414D
            echo mail_module
        end
        if ngx_modules[$i].type == 0x50545448
            echo http_module
        end
        echo \n

        p *ngx_modules[$i]
        set $cmd = ngx_modules[$i]->commands

        if $cmd != 0
            set $j = 0
            while $cmd[$j].name.len !=0
                # command's type
                echo \n
                echo command's type :
                if $cmd[$j].type&0x01000000
                    echo main_conf,
                end
                if $cmd[$j].type&0x0F000000
                    echo any_conf,
                end
                if $cmd[$j].type&0x00000100
                    echo conf_block,
                end
                if $cmd[$j].type&0x00000200
                    echo conf_flag,
                end
                echo \n

                # command's detail
                p $cmd[$j]
                set $j++
            end
        end
    end
end

document pnmodule
    Print ngx_modules's infomation.
end


define pnallmodule
    set $i = 0
    set $module = ngx_modules[$i]
    while $module != 0
        pnmodule $i
        set $i++
    end
end

# vi:ft=gdb ts=4 sw=4

