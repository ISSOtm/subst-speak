# subst-speak

A small program to have two computers dialog using a substitution cipher. Intended to be part of [this activity](https://eldred.fr/slides/reveal.js/slides/subst-speak.html).

Dependencies: a Bash-compatible shell (+ accompanying environment), and `socat`.

To run: `./launch.bash <sender-nick> <conv-file>`, `conv-file` containing the lines that will be output. Launch on two different machines on the same network (with different nicks and conversation files, ideally), and have other machines monitor what they recieve from 255.255.255.255 on UDP port 6666.

## License

MIT.
