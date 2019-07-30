#!/usr/bin/env sh

update-alternatives --install /usr/bin/ld ld /opt/llvm/bin/ld.lld 10
update-alternatives --install /usr/bin/ar ar /opt/llvm/bin/llvm-ar 10
update-alternatives --install /usr/bin/as as /opt/llvm/bin/llvm-as 10
update-alternatives --install /usr/bin/nm nm /opt/llvm/bin/llvm-nm 10
update-alternatives --install /usr/bin/objcopy objcopy /opt/llvm/bin/llvm-objcopy 10
update-alternatives --install /usr/bin/objdump objdump /opt/llvm/bin/llvm-objdump 10
update-alternatives --install /usr/bin/ranlib ranlib /opt/llvm/bin/llvm-ranlib    10
update-alternatives --install /usr/bin/readelf readelf /opt/llvm/bin/llvm-readelf 10
update-alternatives --install /usr/bin/size size /opt/llvm/bin/llvm-size          10
update-alternatives --install /usr/bin/strings strings /opt/llvm/bin/llvm-strings 10
update-alternatives --install /usr/bin/strip strip /opt/llvm/bin/llvm-strip       10
