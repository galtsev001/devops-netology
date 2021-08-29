## 4.2. Использование Python для решения типовых DevOps задач

#### 1) Есть скрипт:
```bash
    #!/usr/bin/env python3
    a = 1
    b = '2'
    c = a + b
```
+ Какое значение будет присвоено переменной c?
+ Как получить для переменной c значение 12?
+ Как получить для переменной c значение 3?

***Ответ:***

1) Будет ошибка, нельзя сложить тип данных int и string
2) Если нужно число, то можно перезаписать переменную `b` в число 11 => `c = a + b`. Если необходима строка, то то можно перезаписать переменную `a = '1'` => `c = a + b` 
2) Если нужно число, то можно перезаписать переменную `b` в число 2 => `c = a + b` 
    

#### 2) Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?
```bash
    #!/usr/bin/env python3
    
    import os
    
    bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
    result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
    for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(prepare_result)
            break
```
#### 3) Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

***Ответ 2 -3 вопрос:***

```bash
    import os
    a = input("Please, enter DIR: ")
    
    bash_command = [ a, "git status -s"]
    result_os = os.popen (' && '.join(bash_command)).read()
    is_change = False
    
    for result in result_os.split('\n'):
      if result.find('??') !=-1:
        prepare_result = result.replace('??', 'Not staged:')                                    
        print(prepare_result)                                                                         
      elif result.find('M') !=-1:
        prepare_result2 = result.replace('M', 'Staged:')                                
        print(prepare_result2)                                                                    
      elif result.find('A') != -1:
        prepare_result3 = result.replace('A', 'Staged without changes:')                             
        print(prepare_result3)
```

#### 4) Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.

***Ответ:***

**services.txt**
```bash
    drive.google.com;mail.google.com;google.com
```

**SCRIPT**

```bash
    import socket
    
    lookupList = []
    
    with open('/home/vagrant/services.txt', 'rt') as file:
        line = file.readline()
    
        while line:
            line = line.split(';')
            if len(line) > 1:
    
                try:
                    newIp = socket.gethostbyname(line[0])
                except socket.SO_ERROR:
                    print('Lookup error!')
    
                if newIp != line[1].strip():
                    print(f'[ERROR] {line[0]} IP mismatch: {line[1].strip()} {newIp}')
                lookupList.append(line[0] + ' ' + newIp)
            line = file.readline()
    
    with open('/home/vagrant/services.txt', 'wt') as file:
        for line in lookupList:
            file.write(line + '\n')
```