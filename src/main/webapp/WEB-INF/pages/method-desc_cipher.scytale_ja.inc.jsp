<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>スキュタレー暗号について</h3>
<p>スキュタレー暗号は、文章の文字を並べ替えることで暗号化する転置式暗号のひとつです。スキュタレーはギリシャ語でバトンを意味しています。</p>
<p>棒に細長い羊皮紙を巻きつけ、羊皮紙を横断して文字を書いていくことで暗号化します。</p>
<p>羊皮紙を棒に巻き付けた回数（1行に書き込める最大文字数）が暗号のキーになります。</p>

<p>例えば、羊皮紙の巻き回数が6で「THIS_IS_A_SECRET_MESSAGE」を暗号化する場合は以下のようになります。</p>

<p>1. 羊皮紙を横断して文字を配置します。巻き回数が6のため、1行あたり6文字を書き込んでいきます。</p>
<pre>-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------</pre>

<p>2. 棒から羊皮紙をほどくことで暗号化されます。</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>