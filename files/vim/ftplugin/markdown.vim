" Markdown


"Use \w in normal mode to save the current file AND save a copy in html named:
"   original_filename.html
"The perl command will encode most unicode characters (e.g é becomes 
"The last part will revert the changes in the original markdown file and put a
"command for viewing the created html file in the command line, user can then
"type ENTER to view the file or ESC to continue working
"
" \ :%!perl -MHTML::Entities -MEncode -p -i -e '$_=Encode::decode_utf8($_) unless Encode::is_utf8($_); $_=HTML::Entities::encode_entities($_);'<cr>
nmap <leader>w :w<cr>
  \ :%!perl -p -i -e 'BEGIN { use HTML::Entities; use Encode; } $_=Encode::decode_utf8($_) unless Encode::is_utf8($_); $_=Encode::encode("ascii", $_, sub{HTML::Entities::encode_entities(chr shift)});'<cr>
  \ :%!Markdown.pl --html4tags<cr>
  \ :w! %:p.html<cr>
  \ u
  \ :view %:p.html


