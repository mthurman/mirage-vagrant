# !/bin/env bash
cd ~
mkdir code
cd code
git clone git://github.com/OCamlPro/opam.git
cd opam && ./configure && make
sudo make install

opam init
opam remote -add dev git://github.com/mirage/opam-repo-dev
opam pin mirage-net git://github.com/mirage/mirage-net
opam update

echo "export EC2_USER=XXXX" >> ~/.profile
echo "export EC2_ACCESS=XXXX" >> ~/.profile
echo "export EC2_ACCESS_SECRET=XXXX" >> ~/.profile
echo "export EC2_CERT=$HOME/code/ec2/cert-XXXX.pem" >> ~/.profile
echo "export EC2_PRIVATE_KEY=$HOME/code/ec2/pk-XXXX.pem" >> ~/.profile
echo "eval \`opam config -env\`" >> ~/.profile

eval . ~/.profile
# dirty but the install script needs it
sudo chmod o+w /usr/local/bin
opam install mirage mirage-net mirage-fs ocamlfind cohttp re cow
opam switch 3.12.1+mirage-xen
eval `opam config -env`
unset CAML_LD_LIBRARY_PATH
opam install mirage mirage-net mirage-fs ocamlfind cohttp re cow
opam switch system
eval `opam config -env`
