
https://gist.github.com/lucasw/47f4041f79aea451c186870c33af4019


## asm syntax highlighting in vim

https://stackoverflow.com/questions/33474506/modify-syntax-highlighting-in-vim-remove-as-comment

Download armasm.vim from
http://www.vim.org/scripts/script.php?script_id=888

```
mkdir ~/.vim/syntax
mv ~/Downloads/armasm.vim ~/.vim/syntax
```

Edit `~/.vimrc`:

```
let asmsyntax='armasm'
let filetype_inc='armasm'
```


Original README:

# amiga-assembly-crashcourse

Example program source code for crash course blog post on Amiga assembly.

Read the blog post [here][amiga-assembly-crashcourse-blog].

[amiga-assembly-crashcourse-blog]: http://reaktor.com/blog/crash-course-to-amiga-assembly-programming/
