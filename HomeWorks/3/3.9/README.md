## 3.9. Элементы безопасности информационных систем

#### 1) Установите Hashicorp Vault в виртуальной машине Vagrant/VirtualBox. Это не является обязательным для выполнения задания, но для лучшего понимания что происходит при выполнении команд (посмотреть результат в UI), можно по аналогии с netdata из прошлых лекций пробросить порт Vault на localhost:
```bash
config.vm.network "forwarded_port", guest: 8200, host: 8200
```
Однако, обратите внимание, что только-лишь проброса порта не будет достаточно – по-умолчанию Vault слушает на 127.0.0.1; добавьте к опциям запуска -dev-listen-address="0.0.0.0:8200".

***Ответ***

<span style="display:block;text-align:center">![image#1 ](./img/1.png)</span>

#### 2) Запустить Vault-сервер в dev-режиме (дополнив ключ -dev упомянутым выше -dev-listen-address, если хотите увидеть UI).

***Ответ***

<span style="display:block;text-align:center">![image#1 ](./img/2.1.png)</span>

<span style="display:block;text-align:center">![image#1 ](./img/2.2.png)</span>

#### 3) Используя PKI Secrets Engine, создайте Root CA и Intermediate CA. Обратите внимание на дополнительные материалы по созданию CA в Vault, если с изначальной инструкцией возникнут сложности.

***Ответ***


