build: a.out
a.out: main.cpp
	clang++-16 $(cat ./compile_flags.txt | sed -z 's/\n/ /g') main.cpp
test: a.out
	oj t
test-about: a.out
	oj t -e 1e-6
submit: main.cpp
	oj s main.cpp -y --guess-cxx-compiler clang
test-submit: test
	make submit
test-about-submit: test-about
	make submit
login:
	oj login https://atcoder.jp/
