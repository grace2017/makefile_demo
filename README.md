# makefile_demo
模拟Makefile在实际工作中的一个demo

功能：
1、生成Debug版、Realease版
2、利用目录管理各种文件
3、创建、编译、清除模块，可扩展
4、编译、清除、使用动态或静态库，可扩展
5、支持第三方库的使用
6、安装、卸载、测试

make                编译项目
make clean          清除项目
make create_module  创建模块
make build_module   编译模块
make clean_module   清除模块
make install        安装
make uninstall      卸载
make test           测试

编译：
make build_module
make

安装：
make install

卸载：
make uninstall

清除：
make clean
