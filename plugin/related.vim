" Author:      Donald Chea
" Version:     0.1.1
" Description: Open a related file based on the path.

" Open the related file in a vsplit
function! s:RelatedFile(open_method)
  let related = s:GetRelated(expand('%:p'))
  if related ==# ''
    echo "Unable to find related file."
    return
  endif

  exec(s:OpenCommand(a:open_method) . ' ' . related)
endfunction

" Return the command to open the related file
function! s:OpenCommand(cmd)
  let open_commands = { 'sp': 'split', 'vs': 'vsplit', 'e': 'edit' }
  return get(open_commands, a:cmd, 'vsplit')
endfunction

" Find src or test file based on a file path.
"
" The format is based on PSR-0 naming conventions for PHP classes:
" https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md
"
" The test file is named based from the source file.
"
" [path]/src/[Vendor]/[Namespace]/[Class].php
" [path]/tests/[Vendor]/Tests/[Namespace]/[Class]Test.php
"
" ie. src/Me/Hello/There.php -> tests/Me/Tests/Hello/ThereTest.php
function! s:GetRelated(file)
  if match(a:file, 'src') >=# 0
    let path = substitute(a:file, '\vsrc/([^/]+)/(([^/]+/)+)?(.*).php$', 'tests/\1/Tests/\2\4Test.php', '')
    if path !=# a:file
      return path
    endif
  elseif match(a:file, 'tests') >=# 0
    let path = substitute(a:file, '\vtests/([^/]+)/Tests/(([^/]+/)+)?(.*)Test.php$', 'src/\1/\2\4.php', '')
    if path !=# a:file
      return path
    endif
  endif

  return ''
endfunction

" Unit Tests!
function! s:RunTests()
  let s:test_number = 0
  let s:passes = 0

  echo "Test s:GetRelated"
  " Not in the proper format
  call s:Equals('', s:GetRelated('blah.php'))
  " Proper format, source file
  call s:Equals('tests/Vendor/Tests/Namespace/ClassTest.php', s:GetRelated('src/Vendor/Namespace/Class.php'))
  " Proper format, test file
  call s:Equals('src/Vendor/Namespace/Class.php', s:GetRelated('tests/Vendor/Tests/Namespace/ClassTest.php'))
  " Proper format, source file, with prefix
  call s:Equals('/path/to/tests/Vendor/Tests/Namespace/ClassTest.php', s:GetRelated('/path/to/src/Vendor/Namespace/Class.php'))
  " Proper format, test file, with prefix
  call s:Equals('/path/to/src/Vendor/Namespace/Class.php', s:GetRelated('/path/to/tests/Vendor/Tests/Namespace/ClassTest.php'))
  " Proper format, source file, with prefix, deep namespace
  call s:Equals('path/to/tests/Vendor/Tests/Namespace/A/B/ClassTest.php', s:GetRelated('path/to/src/Vendor/Namespace/A/B/Class.php'))
  " Proper format, test file, with prefix, deep namespace
  call s:Equals('path/to/src/Vendor/Namespace/A/B/Class.php', s:GetRelated('path/to/tests/Vendor/Tests/Namespace/A/B/ClassTest.php'))
  " Proper format, source file, no namespace
  call s:Equals('tests/Vendor/Tests/ClassTest.php', s:GetRelated('src/Vendor/Class.php'))
  " Proper format, test file, no namespace
  call s:Equals('src/Vendor/Class.php', s:GetRelated('tests/Vendor/Tests/ClassTest.php'))

  echo "Test s:OpenCommand"
  call s:Equals('vsplit', s:OpenCommand('vs'))
  call s:Equals('split', s:OpenCommand('sp'))
  call s:Equals('edit', s:OpenCommand('e'))
  " Defaults to vsplit
  call s:Equals('vsplit', s:OpenCommand(''))
  call s:Equals('vsplit', s:OpenCommand('does-not-exist'))

  echo printf("\nFinished test suite - %d of %d tests passed (%d%%)", s:passes, s:test_number, s:passes*100/s:test_number)
endfunction

function! s:Equals(expect, actual)
  let s:test_number = s:test_number + 1

  if a:expect ==# a:actual
    echo printf("%10s %s", "Test " . s:test_number . ":", "PASS")
    let s:passes = s:passes + 1
  else
    echo printf("%10s %s", "Test " . s:test_number . ":", "FAIL")
    echo printf("%20s %s", "Expected:", a:expect)
    echo printf("%20s %s", "Actual:", a:actual)
  endif
endfunction

command! -nargs=? RelatedFile :call <SID>RelatedFile(<q-args>)
command! RelatedTests :call <SID>RunTests()
