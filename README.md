1. VirtualBox уже был установлен.
2. Hashicorp Vagrant установлен.
3. Windows Terminal установлен, кастомизирован, про возможности кастомизации прочитала.
4. Виртуалка Ubuntu установлена без сложностей.
5. По умолчанию виртуалке выделено 1024 оперативной памяти, 2 ядра процессора, 64 ГБ под жесткий диск динамически расширяемый, сетевой адаптер, использующий NAT, общая папка для обмена с хостом
6. Оперативной памяти или ресурсов процессора виртуалке можно добавить с помощью VirtualBoxManage, это консольная утилита, работающая из командной строки. Например, установить количество ядер можно с помощью этого ключа
--cpus <cpucount>: Sets the number of virtual CPUs for the virtual machine
а установить размер оперативной памяти в МБ с помощью этого
--memory
Так же vagrant может передать команды в virtualboxmanage с помощью директив
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end
7. С большей частью команд была знакома раннее.
8. Длину журнала history можно задать переменной HISTFILESIZE, описано на 1155 строчке man bash 
директива ignoreboth заменяет две директивы - ignorespace и ignoredups, одна из которых говорит не сохранять команды начинающиеся на пробел в хистори, а вторая - не сохранять строки, дублирующие предыдущую команду.
9. {} используется если нужно обработать последовательность. Например, диапазон чисел
строка 1508 man bash
10. touch file{1..100000}
но у меня выдало unable to execute /usr/bin/touch: Argument list too long так что 300000 файлов тоже не получится, нужно делать с помощью цикла чтобы обойти ограничение ARG_MAX
11. [[]] это примерно то же что и [], но поддерживает регулярные выражения и внутри можно использовать выражения без спец символов "", \ 
Эта конструкция выполняет проверку условий. 
Таким образом, [[ -d /tmp ]] проверяет, существует ли каталог /tmp и возвращает значение 0 (истина) или 1 (ложь).
12. mkdir /tmp/new_path_directory
    cp  /usr/bin/bash /tmp/new_path_directory/bash
    export PATH='/tmp/new_path_directory:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin'
    
    итог:
    type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash
13. и at и batch используются для планирования задач. При этом, если нужно, чтобы эти задачи выполнялись в моменты низкой нагрузки системы, то используется batch 
14. Сделано с помощью команды vagrant suspend