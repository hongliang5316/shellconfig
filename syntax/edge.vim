" Vim syntax file
" Some of the code inherent from perl.vim
" Language: Edge Language for CloudFlare
" Maintainer: Guanlan Dai

" Keywords

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

if exists('&regexpengine')
  let s:regexpengine=&regexpengine
  set regexpengine=1
endif

syn cluster edgeTop		contains=TOP

syn region edgeBraces start="{" end="}" transparent extend

" All keywords
"
" for some reason, adding this as the nextgroup for edgeControl fixes BEGIN
" folding issues...
syn match edgeFakeGroup 	"" contained
syn match edgeControl		"\<\%(done\|redo\|server\|block\|action\|for\|if\|else\|as\|my\|our\)\>"
syn keyword edgeTodo			TODO TODO: TBD TBD: FIXME FIXME: XXX XXX: NOTE NOTE: contained

" Build-in functions
syn match edgeStatementProc	"\<\%(mime-type\|include\|set-mime-type\|scheme\|defined\|call\|uri-rm-segs\|decode-base64\|uri-seg\|resp-header\|subst-resp-body-matched\|uri-args\|host\|set-req-header\|remove-uri-arg\|uri-arg\|uri\|set-req-host\|resolve-origin\|rewrite-resp-host\)\>"
syn match edgeStatementProc	"\<\%(rewrite-origin-cookie-host\|rewrite-resp-redirect-host\|now\)\>"
syn match edgeStatementProc	"\<\%(remove-req-header\|uri-prefix\|test-bit\|referer\)\>"
syn match edgeStatementProc	"\<\%(strip-uri-prefix\|add-resp-cookie\|add-uri-args\|rewrite-uri-prefix\|add-uri-prefix\)\>"
syn match edgeStatementProc	"\<\%(req-header\|ua-is-mobile\|redirect\|remove-req-cookie\|req-cookie\|fact\)\>"
syn match edgeStatementProc	"\<\%(client-region\|redirect\|rewrite-resp-host\|set-req-host\|resp-body-scan\)\>"
syn match edgeStatementProc	"\<\%(substr\|md5-hex\|parse-hex\|true\|false\)\>"
syn match edgeStatementProc	"\<\%(set-cache-level\|set-uri-args\|clear-uri-args\|set-uri\|rewrite-resp-cookie-host\|expires\)\>"
syn match edgeStatementProc	"\<\%(exit\|errlog\)\>"
syn match edgeStatementProc	"\<\%(referer-host\|add-resp-header\|remove-resp-header-param\|remove-resp-header\|uri-suffix\|resp-status\|uri-basename\|set-resp-header\)\>"
syn match edgeStatementProc	"\<\%(add-fact\|zone-name\|resp-header-param\|user-agent-contains\|user-agent\)\>"
syn match edgeStatementProc	"\<\%(set-cache-ttl\|set-cache-key\|set-expire-ttl\|uri-contains\|random-hits\|rand\)\>"
syn match edgeStatementProc	"\<\%(colo-region\|lower-case\|req-cookie-value\)\>"
syn match edgeStatementProc	"\<\%(uuid-v4\|replace-suffix\|client-addr\|looks-like-num\|looks-like-uint\|looks-like-int\)\>"


" edge Identifiers.
"
" Should be cleaned up to better handle identifiers in particular situations
" (in hash keys for example)
"
" Plain identifiers: $foo, @foo, $#foo, %foo, &foo and dereferences $$foo, @$foo, etc.
" We do not process complex things such as @{${"foo"}}. Too complicated, and
" too slow. And what is after the -> is *not* considered as part of the
" variable - there again, too complicated and too slow.

" Special variables first ($^A, ...) and ($|, $', ...)
syn match  edgeVarPlain		 "$^[ACDEFHILMNOPRSTVWX]\="
syn match  edgeVarPlain		 "$[\\\"\[\]'&`+*.,;=%~!?@#$<>(-]"
syn match  edgeVarPlain		 "%+"
syn match  edgeVarPlain		 "$\%(0\|[1-9]\d*\)"
" Same as above, but avoids confusion in $::foo (equivalent to $main::foo)
syn match  edgeVarPlain		 "$::\@!"
" These variables are not recognized within matches.
syn match  edgeVarNotInMatches	 "$[|)]"
" This variable is not recognized within matches delimited by m//.
syn match  edgeVarSlash		 "$/"

" And plain identifiers
syn match  edgePackageRef	 "[$@#%*&]\%(\%(::\|'\)\=\I\i*\%(\%(::\|'\)\I\i*\)*\)\=\%(::\|'\)\I"ms=s+1,me=e-1 contained

" To not highlight packages in variables as a scope reference - i.e. in
" $pack::var, pack:: is a scope, just set "edge_no_scope_in_variables"
" If you don't want complex things like @{${"foo"}} to be processed,
" just set the variable "edge_no_extended_vars"...

if !exists("edge_no_scope_in_variables")
  syn match  edgeVarPlain       "\%([@$]\|\$#\)\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=edgePackageRef nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod
  syn match  edgeVarPlain2                   "%\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=edgePackageRef
  syn match  edgeFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=edgePackageRef nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod
else
  syn match  edgeVarPlain       "\%([@$]\|\$#\)\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod
  syn match  edgeVarPlain2                   "%\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)"
  syn match  edgeFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod
endif

if !exists("edge_no_extended_vars")
  syn cluster edgeExpr		contains=edgeStatementTime,edgeStatementMisc,edgeVarPlain,edgeVarPlain2,edgeVarNotInMatches,edgeVarSlash,edgeVarBlock,edgeVarBlock2,edgeShellCommand,edgeFloat,edgeNumber,edgeStringUnexpanded,edgeString,edgeQQ,edgeArrow,edgeBraces
  syn region edgeArrow		matchgroup=edgeArrow start="->\s*(" end=")" contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod contained
  syn region edgeArrow		matchgroup=edgeArrow start="->\s*\[" end="\]" contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod contained
  syn region edgeArrow		matchgroup=edgeArrow start="->\s*{" end="}" contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod contained
  syn match  edgeArrow		"->\s*{\s*\I\i*\s*}" contains=edgeVarSimpleMemberName nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod contained
  syn region edgeArrow		matchgroup=edgeArrow start="->\s*\$*\I\i*\s*(" end=")" contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod contained
  syn region edgeVarBlock	matchgroup=edgeVarPlain start="\%($#\|[$@]\)\$*{" skip="\\}" end=+}\|\%(\%(<<\%('\|"\)\?\)\@=\)+ contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod extend
  syn region edgeVarBlock2	matchgroup=edgeVarPlain start="[%&*]\$*{" skip="\\}" end=+}\|\%(\%(<<\%('\|"\)\?\)\@=\)+ contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod extend
  syn match  edgeVarPlain2	"[%&*]\$*{\I\i*}" nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod extend
  syn match  edgeVarPlain	"\%(\$#\|[@$]\)\$*{\I\i*}" nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod extend
  syn region edgeVarMember	matchgroup=edgeVarPlain start="\%(->\)\={" skip="\\}" end="}" contained contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod extend
  syn match  edgeVarSimpleMember	"\%(->\)\={\s*\I\i*\s*}" nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod contains=edgeVarSimpleMemberName contained extend
  syn match  edgeVarSimpleMemberName	"\I\i*" contained
  syn region edgeVarMember	matchgroup=edgeVarPlain start="\%(->\)\=\[" skip="\\]" end="]" contained contains=@edgeExpr nextgroup=edgeVarMember,edgeVarSimpleMember,edgeMethod extend
  syn match  edgeMethod		"->\$*\I\i*" contained nextgroup=edgeVarSimpleMember,edgeVarMember,edgeMethod
endif

" Special characters in strings and matches
syn match  edgeSpecialString	"\\\%(\o\{1,3}\|x\%({\x\+}\|\x\{1,2}\)\|c.\|[^cx]\)" contained extend
syn match  edgeSpecialStringU2	"\\." extend contained contains=NONE
syn match  edgeSpecialStringU	"\\\\" contained
syn match  edgeSpecialMatch	"\\[1-9]" contained extend
syn match  edgeSpecialMatch	"\\g\%(\d\+\|{\%(-\=\d\+\|\h\w*\)}\)" contained
syn match  edgeSpecialMatch	"\\k\%(<\h\w*>\|'\h\w*'\)" contained
syn match  edgeSpecialMatch	"{\d\+\%(,\%(\d\+\)\=\)\=}" contained
syn match  edgeSpecialMatch	"\[[]-]\=[^\[\]]*[]-]\=\]" contained extend
syn match  edgeSpecialMatch	"[+*()?.]" contained
syn match  edgeSpecialMatch	"(?[#:=!]" contained
syn match  edgeSpecialMatch	"(?[impsx]*\%(-[imsx]\+\)\=)" contained
syn match  edgeSpecialMatch	"(?\%([-+]\=\d\+\|R\))" contained
syn match  edgeSpecialMatch	"(?\%(&\|P[>=]\)\h\w*)" contained
syn match  edgeSpecialMatch	"(\*\%(\%(PRUNE\|SKIP\|THEN\)\%(:[^)]*\)\=\|\%(MARK\|\):[^)]*\|COMMIT\|F\%(AIL\)\=\|ACCEPT\))" contained

" Possible errors
"
" Highlight lines with only whitespace (only in blank delimited here documents) as errors
syn match  edgeNotEmptyLine	"^\s\+$" contained
" Highlight "} else if (...) {", it should be "} else { if (...) { " or "} elsif (...) {"
syn match edgeElseIfError	"else\_s*if" containedin=edgeConditional
syn keyword edgeElseIfError	elseif containedin=edgeConditional

" Variable interpolation
"
" These items are interpolated inside "" strings and similar constructs.
syn cluster edgeInterpDQ	contains=edgeSpecialString,edgeVarPlain,edgeVarNotInMatches,edgeVarSlash,edgeVarBlock
" These items are interpolated inside '' strings and similar constructs.
syn cluster edgeInterpSQ	contains=edgeSpecialStringU,edgeSpecialStringU2
" These items are interpolated inside m// matches and s/// substitutions.
syn cluster edgeInterpSlash	contains=edgeSpecialString,edgeSpecialMatch,edgeVarPlain,edgeVarBlock
" These items are interpolated inside m## matches and s### substitutions.
syn cluster edgeInterpMatch	contains=@edgeInterpSlash,edgeVarSlash

" Shell commands
syn region  edgeShellCommand	matchgroup=edgeMatchStartEnd start="`" end="`" contains=@edgeInterpDQ keepend

" Constants
"
" Numbers
syn match  edgeNumber	"\<\%(0\%(x\x[[:xdigit:]_]*\|b[01][01_]*\|\o[0-7_]*\|\)\|[1-9][[:digit:]_]*\)\>"
syn match  edgeFloat	"\<\d[[:digit:]_]*[eE][\-+]\=\d\+"
syn match  edgeFloat	"\<\d[[:digit:]_]*\.[[:digit:]_]*\%([eE][\-+]\=\d\+\)\="
syn match  edgeFloat    "\.[[:digit:]][[:digit:]_]*\%([eE][\-+]\=\d\+\)\="

" syn match  edgeString	"\<\%(v\d\+\%(\.\d\+\)*\|\d\+\%(\.\d\+\)\{2,}\)\>" contains=edgeVStringV
syn match  edgeVStringV	"\<v" contained


syn region edgeParensSQ		start=+(+ end=+)+ extend contained contains=edgeParensSQ,@edgeInterpSQ keepend
syn region edgeBracketsSQ	start=+\[+ end=+\]+ extend contained contains=edgeBracketsSQ,@edgeInterpSQ keepend
syn region edgeBracesSQ		start=+{+ end=+}+ extend contained contains=edgeBracesSQ,@edgeInterpSQ keepend
syn region edgeAnglesSQ		start=+<+ end=+>+ extend contained contains=edgeAnglesSQ,@edgeInterpSQ keepend

syn region edgeParensDQ		start=+(+ end=+)+ extend contained contains=edgeParensDQ,@edgeInterpDQ keepend
syn region edgeBracketsDQ	start=+\[+ end=+\]+ extend contained contains=edgeBracketsDQ,@edgeInterpDQ keepend
syn region edgeBracesDQ		start=+{+ end=+}+ extend contained contains=edgeBracesDQ,@edgeInterpDQ keepend
syn region edgeAnglesDQ		start=+<+ end=+>+ extend contained contains=edgeAnglesDQ,@edgeInterpDQ keepend

" Below some hacks to recognise the // variant. This is virtually impossible to catch in all
" cases as the / is used in so many other ways, but these should be the most obvious ones.
syn region edgeMatch	matchgroup=edgeMatchStartEnd start="\%([$@%&*]\@<!\%(\<split\|\<while\|\<if\|\<unless\|\.\.\|[-+*!~(\[{=]\)\s*\)\@<=/\%(/=\)\@!" start=+^/\%(/=\)\@!+ start=+\s\@<=/\%(/=\)\@![^[:space:][:digit:]$@%=]\@=\%(/\_s*\%([([{$@%&*[:digit:]"'`]\|\_s\w\|[[:upper:]_abd-fhjklnqrt-wyz]\)\)\@!+ skip=+\\/+ end=+/[msixpodualgc]*+ contains=@edgeInterpSlash extend


" Strings and wc, qw and rx expressions

syn region edgeStringUnexpanded	matchgroup=edgeStringStartEnd start="'" end="'" contains=@edgeInterpSQ keepend extend
syn region edgeString		matchgroup=edgeStringStartEnd start=+"+  end=+"+ contains=@edgeInterpDQ keepend extend

syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!wc\>\s*\z([^[:space:]#([{<]\)+ end=+\z1+ contains=@edgeInterpDQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!wc#+ end=+#+ contains=@edgeInterpDQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!wc\s*(+ end=+)+ contains=@edgeInterpDQ,edgeParensDQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!wc\s*\[+ end=+\]+ contains=@edgeInterpDQ,edgeBracketsDQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!wc\s*{+ end=+}+ contains=@edgeInterpDQ,edgeBracesDQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!wc\s*<+ end=+>+ contains=@edgeInterpDQ,edgeAnglesDQ keepend extend

syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw\s*\z([^[:space:]#([{<]\)+  end=+\z1+ contains=@edgeInterpSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw#+  end=+#+ contains=@edgeInterpSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw\s*(+  end=+)+ contains=@edgeInterpSQ,edgeParensSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw\s*\[+  end=+\]+ contains=@edgeInterpSQ,edgeBracketsSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw\s*{+  end=+}+ contains=@edgeInterpSQ,edgeBracesSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw\s*<+  end=+>+ contains=@edgeInterpSQ,edgeAnglesSQ keepend extend

syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!rx\s*\z([^[:space:]#([{<]\)+  end=+\z1+ contains=@edgeInterpSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!rx+  end=+#+ contains=@edgeInterpSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!rx\s*(+  end=+)+ contains=@edgeInterpSQ,edgeParensSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!rx\s*\[+  end=+\]+ contains=@edgeInterpSQ,edgeBracketsSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!rx\s*{+  end=+}+ contains=@edgeInterpSQ,edgeBracesSQ keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!rx\s*<+  end=+>+ contains=@edgeInterpSQ,edgeAnglesSQ keepend extend

" A special case for qr{}, qr<> and qr[] which allows for comments and extra whitespace in the pattern
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qr\s*{+  end=+}[imosx]*+ contains=@edgeInterpMatch,edgeBracesDQ,edgeComment keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qr\s*<+  end=+>[imosx]*+ contains=@edgeInterpMatch,edgeAnglesDQ,edgeComment keepend extend
syn region edgeQQ		matchgroup=edgeStringStartEnd start=+\<\%(::\|'\|->\)\@<!qr\s*\[+  end=+\][imosx]*+ contains=@edgeInterpMatch,edgeBracketsDQ,edgeComment keepend extend

" Constructs such as print <<EOF [...] EOF, 'here' documents
"
" XXX Any statements after the identifier are in edgeString colour (i.e.
" 'if $a' in 'print <<EOF if $a'). This is almost impossible to get right it
" seems due to the 'auto-extending nature' of regions.
if exists("edge_fold")
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\z(\I\i*\).*+    end=+^\z1$+ contains=@edgeInterpDQ fold extend
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*"\z([^\\"]*\%(\\.[^\\"]*\)*\)"+ end=+^\z1$+ contains=@edgeInterpDQ fold extend
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*'\z([^\\']*\%(\\.[^\\']*\)*\)'+ end=+^\z1$+ contains=@edgeInterpSQ fold extend
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*""+           end=+^$+    contains=@edgeInterpDQ,edgeNotEmptyLine fold extend
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*''+           end=+^$+    contains=@edgeInterpSQ,edgeNotEmptyLine fold extend
  syn region edgeAutoload	matchgroup=edgeStringStartEnd start=+<<\s*\(['"]\=\)\z(END_\%(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)\1+ end=+^\z1$+ contains=ALL fold extend
else
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\z(\I\i*\).*+    end=+^\z1$+ contains=@edgeInterpDQ
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*"\z([^\\"]*\%(\\.[^\\"]*\)*\)"+ end=+^\z1$+ contains=@edgeInterpDQ
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*'\z([^\\']*\%(\\.[^\\']*\)*\)'+ end=+^\z1$+ contains=@edgeInterpSQ
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*""+           end=+^$+    contains=@edgeInterpDQ,edgeNotEmptyLine
  syn region edgeHereDoc	matchgroup=edgeStringStartEnd start=+<<\s*''+           end=+^$+    contains=@edgeInterpSQ,edgeNotEmptyLine
  syn region edgeAutoload	matchgroup=edgeStringStartEnd start=+<<\s*\(['"]\=\)\z(END_\%(SUB\|OF_FUNC\|OF_AUTOLOAD\)\)\1+ end=+^\z1$+ contains=ALL
endif


" Class declarations
"
syn match   edgePackageDecl		"\<package\s\+\%(\h\|::\)\%(\w\|::\)*" contains=edgeStatementPackage
syn keyword edgeStatementPackage	package contained

" The => operator forces a bareword to the left of it to be interpreted as
" a string
syn match  edgeString "\I\@<!-\?\I\i*\%(\s*=>\)\@="

" All other # are comments, except ^#!
syn match  edgeComment		"#.*" contains=edgeTodo,@Spell extend
syn match  edgeSharpBang	"^#!.*"

" Formats
syn match  edgeFormatName	"format\s\+\k\+\s*="lc=7,me=e-1 contained
syn match  edgeFormatField	"[@^][|<>~]\+\%(\.\.\.\)\=" contained
syn match  edgeFormatField	"[@^]#[#.]*" contained
syn match  edgeFormatField	"@\*" contained
syn match  edgeFormatField	"@[^A-Za-z_|<>~#*]"me=e-1 contained
syn match  edgeFormatField	"@$" contained

" __END__ and __DATA__ clauses
if exists("edge_fold")
  syntax region edgeDATA		start="^__DATA__$" skip="." end="." fold
  syntax region edgeDATA		start="^__END__$" skip="." end="." contains=edgePOD,@edgeDATA fold
else
  syntax region edgeDATA		start="^__DATA__$" skip="." end="."
  syntax region edgeDATA		start="^__END__$" skip="." end="." contains=edgePOD,@edgeDATA
endif

"
" Folding

if exists("edge_fold")
  " Note: this bit must come before the actual highlighting of the "package"
  " keyword, otherwise this will screw up Pod lines that match /^package/
  if !exists("edge_nofold_packages")
    syn region edgePackageFold start="^package \S\+;\s*\%(#.*\)\=$" end="^1;\=\s*\%(#.*\)\=$" end="\n\+package"me=s-1 transparent fold keepend
  endif
  if !exists("edge_nofold_subs")
    if exists("edge_fold_anonymous_subs") && edge_fold_anonymous_subs
      syn region edgeSubFold     start="\<sub\>[^\n;]*{" end="}" transparent fold keepend extend
      syn region edgeSubFold     start="\<\%(BEGIN\|END\|CHECK\|INIT\)\>\s*{" end="}" transparent fold keepend
    else
      syn region edgeSubFold     start="^\z(\s*\)\<sub\>.*[^};]$" end="^\z1}\s*\%(#.*\)\=$" transparent fold keepend
      syn region edgeSubFold start="^\z(\s*\)\<\%(BEGIN\|END\|CHECK\|INIT\|UNITCHECK\)\>.*[^};]$" end="^\z1}\s*$" transparent fold keepend
    endif
  endif

  if exists("edge_fold_blocks")
    syn region edgeBlockFold start="^\z(\s*\)\%(if\|elsif\|unless\|for\|while\|until\|given\)\s*(.*)\%(\s*{\)\=\s*\%(#.*\)\=$" start="^\z(\s*\)foreach\s*\%(\%(my\|our\)\=\s*\S\+\s*\)\=(.*)\%(\s*{\)\=\s*\%(#.*\)\=$" end="^\z1}\s*;\=\%(#.*\)\=$" transparent fold keepend
    syn region edgeBlockFold start="^\z(\s*\)\%(do\|else\)\%(\s*{\)\=\s*\%(#.*\)\=$" end="^\z1}\s*while" end="^\z1}\s*;\=\%(#.*\)\=$" transparent fold keepend
  endif

  setlocal foldmethod=syntax
  syn sync fromstart
else
  " fromstart above seems to set minlines even if edge_fold is not set.
  syn sync minlines=0
endif

command -nargs=+ HiLink hi def link <args>

" NOTE: If you're linking new highlight groups to edgeString, please also put
"       them into b:match_skip in ftplugin/edge.vim.

" The default highlighting.
HiLink edgeSharpBang	PreProc
HiLink edgeControl		PreProc
HiLink edgeSpecial		Special
HiLink edgeString		String
HiLink edgeNumber		Number
HiLink edgeFloat		Float
HiLink edgeType			Type
HiLink edgeIdentifier	Identifier
HiLink edgeLabel		Label
HiLink edgeStatement	Statement
HiLink edgeConditional	Conditional
HiLink edgeFunction		Keyword
HiLink edgeSubPrototype	Type
HiLink edgeComment		Comment
HiLink edgeTodo			Todo
if exists("edge_string_as_statement")
  HiLink edgeStringStartEnd	edgeStatement
else
  HiLink edgeStringStartEnd	edgeString
endif
HiLink edgeVStringV		edgeStringStartEnd
HiLink edgeVarPlain		edgeIdentifier
HiLink edgeVarPlain2		edgeIdentifier
HiLink edgeArrow		edgeIdentifier
HiLink edgeVarSimpleMember	edgeIdentifier
HiLink edgeVarSimpleMemberName 	edgeString
HiLink edgeVarNotInMatches	edgeIdentifier
HiLink edgeVarSlash		edgeIdentifier
HiLink edgeQQ			edgeString
HiLink edgeHereDoc		edgeString
HiLink edgeStringUnexpanded	edgeString
HiLink edgeSubstitutionSQ	edgeString
HiLink edgeSubstitutionGQQ	edgeString
HiLink edgeTranslationGQ	edgeString
HiLink edgeMatch		edgeString
HiLink edgeMatchStartEnd	edgeStatement
HiLink edgeFormatName		edgeIdentifier
HiLink edgeFormatField		edgeString
HiLink edgePackageDecl		edgeType
HiLink edgeStorageClass		edgeType
HiLink edgePackageRef		edgeType
HiLink edgeStatementPackage	edgeStatement
HiLink edgeStatementControl	edgeStatement
HiLink edgeStatementProc	edgeFunction
HiLink edgeStatementSocket	edgeStatement
HiLink edgeStatementIPC		edgeStatement
HiLink edgeStatementNetwork	edgeStatement
HiLink edgeStatementPword	edgeStatement
HiLink edgeStatementTime	edgeStatement
HiLink edgeStatementMisc	edgeStatement
HiLink edgeStatementIndirObj	edgeStatement
HiLink edgeFunctionName		edgeIdentifier
HiLink edgeMethod		edgeIdentifier
HiLink edgeFunctionPRef		edgeType
HiLink edgePOD			edgeComment
HiLink edgeShellCommand		edgeString
HiLink edgeSpecialString	edgeSpecial
HiLink edgeSpecialStringU	edgeSpecial
HiLink edgeSpecialMatch		edgeSpecial
HiLink edgeDATA			edgeComment

" NOTE: Due to a bug in Vim (or more likely, a misunderstanding on my part),
"       I had to remove the transparent property from the following regions
"       in order to get them to highlight correctly.  Feel free to remove
"       these and reinstate the transparent property if you know how.
HiLink edgeParensSQ		edgeString
HiLink edgeBracketsSQ		edgeString
HiLink edgeBracesSQ		edgeString
HiLink edgeAnglesSQ		edgeString

HiLink edgeParensDQ		edgeString
HiLink edgeBracketsDQ		edgeString
HiLink edgeBracesDQ		edgeString
HiLink edgeAnglesDQ		edgeString

HiLink edgeSpecialStringU2	edgeString

" Possible errors
HiLink edgeNotEmptyLine		Error
HiLink edgeElseIfError		Error
HiLink edgeSubPrototypeError	Error
HiLink edgeSubError		Error

delcommand HiLink

" Syncing to speed up processing
"
if !exists("edge_no_sync_on_sub")
  syn sync match edgeSync	grouphere NONE "^\s*\<package\s"
  syn sync match edgeSync	grouphere NONE "^\s*\<sub\>"
  syn sync match edgeSync	grouphere NONE "^}"
endif

if !exists("edge_no_sync_on_global_var")
  syn sync match edgeSync	grouphere NONE "^$\I[[:alnum:]_:]+\s*=\s*{"
  syn sync match edgeSync	grouphere NONE "^[@%]\I[[:alnum:]_:]+\s*=\s*("
endif

if exists("edge_sync_dist")
  execute "syn sync maxlines=" . edge_sync_dist
else
  syn sync maxlines=100
endif


let b:current_syntax = "edge"

if exists('&regexpengine')
  let &regexpengine=s:regexpengine
  unlet s:regexpengine
endif

let &cpo = s:cpo_save
unlet s:cpo_save

" XXX Change to sts=4:sw=4
" vim:ts=8:sts=2:sw=2:expandtab:ft=vim
