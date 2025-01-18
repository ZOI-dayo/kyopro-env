build: a.out
a.out: main.cpp
	clang++-16 `cat ./compile_flags.txt | sed -z 's/\n/ /g'` main.cpp
bundle: main.bundle.cpp
main.bundle.cpp: main.cpp
	cpp-bundler main.cpp -I /kyopro-lib/atcoder-library -D ONLINE_JUDGE > main.bundle.cpp
test: a.out
	oj t
test-about: a.out
	oj t -e 1e-6
submit: main.bundle.cpp
	oj s main.bundle.cpp -y --guess-cxx-compiler clang --no-open
test-submit: test
	make submit
test-about-submit: test-about
	make submit
login:
	oj login https://atcoder.jp/
print:
	$(eval PROBLEM_NAME := $(shell pwd | sed 's|.*/||'))
	cat -n main.cpp > main.$(PROBLEM_NAME).cpp
	paps main.$(PROBLEM_NAME).cpp --header --landscape=portrait --columns=2 --font="Monospace 8" --stretch-chars="yes" | ps2pdf - out.pdf
	rm main.$(PROBLEM_NAME).cpp
