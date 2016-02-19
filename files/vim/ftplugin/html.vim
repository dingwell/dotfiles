nmap <leader>w :w<cr>
  \ :%!perl -p -i -e 'BEGIN { use HTML::Entities; use Encode; } $_=Encode::decode_utf8($_) unless Encode::is_utf8($_); $_=Encode::encode("ascii", $_, sub{HTML::Entities::encode_entities(chr shift)});'<cr>
  \ :w! %:p_SAFE_.html<cr>
  \ u
  \ :view %:p_SAFE_.html

