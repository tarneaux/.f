#! /usr/bin/fish

if test $argv[1] = "0"
    echo (set_color FFAF87)(dirs) (set_color 00AF00)"λ "
else
    echo (set_color FFAF87)(dirs) (set_color AA0000)"λ "
end
