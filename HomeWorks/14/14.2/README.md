## 14.2 Синхронизация секретов с внешними сервисами. Vault

---
#### Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

![img.png](./img/1.png)

Получить значение внутреннего IP пода

![img.png](./img/2.png)

Примечание: jq - утилита для работы с JSON в командной строке

Запустить второй модуль для использования в качестве клиента

Установить дополнительные пакеты

![img.png](./img/3.png)

![img.png](./img/4.png)

Запустить интепретатор Python и выполнить следующий код, предварительно поменяв IP и токен

![img.png](./img/5.png)
