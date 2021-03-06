# 10.06. Инцидент-менеджмент

## Задание 1

Составьте постмотрем, на основе реального сбоя системы Github в 2018 году.

Информация о сбое доступна [в виде краткой выжимки на русском языке](https://habr.com/ru/post/427301/) , а
также [развёрнуто на английском языке](https://github.blog/2018-10-30-oct21-post-incident-analysis/).

## Задача повышенной сложности

Прослушайте [симуляцию аудиозаписи о инциденте](https://youtu.be/vw6I5DYWkNA?t=1), предоставленную 
разработчиками инструмента для автоматизации инцидент-менеджмента PagerDuty.

На основании этой аудиозаписи попробуйте составить сообщения для пользователей о данном инциденте.

Должно быть 3 сообщения о:
- начале инцидента
- продолжающихся работах
- окончании инцидента и возвращении к штатной работе

---
**Ответ**

| | |
|-|-|
|Краткое описание инцидента|21.10.2018 22:52 на нескольких сервисах GitHub.com была нарушена работа сетевых разделов, что привело к нарушению работы базы данных. Все эти нарушения в работе привели к ухудшению качества обслуживания на 24 часа 11 минут.|
|Предшествующие события| Проводилось техническое обслуживание по замене вышедшего из строя оптического оборудования 100G между Хабом US East Coast network и Основным US East Coast data center|
|Причина инцидента|Потеря сетевого соединения между свитчем US East Coast network и Основным US East Coast data center - 43 секунды. Это привело к рассинхронизации кластеров MySQL.||Воздействие|Сбой работысервиса GitHub, приостановка работы событий (hooks), отображение не актуальной информации на GitHub.com|
|Обнаружение | Обнаружено инженерами обрабатывающими алерты монторинга|
|Реакция |Неисправность сервиса на 24 часа и 11 минут.|
|Восстановление| Были проведены работы по восстановлению сервисов из резервных копий и синхронизации реплик на обоих сайтах. ||Таймлайн |<ul><li>2018.10.21 22:52 UTC - потеря консенсуса между серверами в дата хабах в результате описанного инцидента. После восстановления была попытка восстановления целостности кластера, восстановления консенсуса, но данные в БД различались что привело к несогласованности в рамках кластера</ul></li> <ul><li>2018.10.21 22:54 UTC - Систма мониторинга генерировал Алерты, инженеры поддержки вели их обработку, в 23:02 они обнаружили несоответсвие статуса Кластера БД. Выявлено отсутствие серверов из Хаба US East Coast network.</ul></li><ul><li> 2018.10.21 23:07 UTC - Отключен внутренние инструменны развертывания для предотвращения дополнительных имзменй. Сайт переведен в желтый статус и автомтически зафикисрован инциден в системе управления сбоями</ul></li> <ul><li>2018.10.21 23:13 UTC - Изменение статуса сайта на красный. К решению инцидента привлечены разработчики БД, выпонены действия для сохранения пользовательских данных. Но деградация сервиса не была остановлена</ul></li> <ul><li>2018.10.21 23:19 UTC - Были остановлены некоторые процессы, с целью повышения скорости восстановления и сохранности данных пользователей.</ul></li> <ul><li>2018.10.22 00:05 UTC - Разработка плана по восстановления системы и синхронизаии репликаций данных. Обновлен статус, чтобы проинформировать пользователей о том, что будет выполнено контролируемое аварийное переключение внутренней системы хранения данных.</ul></li> <ul><li>2018.10.22 00:41 UTC - Был начат процесс резервного копирования всех затронутых кластеров MySQL, выполнялся мониторинг состяния работ</ul></li> <ul><li>2018.10.22 06:51 UTC - Данные нескольких кластеров US East Coast data center восстановлены и запущенна репликация данных с серверов в West Coast.</ul></li> <ul><li>2018.10.22 07:46 UTC - Опубликована расширенная информация для пользователей</ul></li> <ul><li>2018.10.22 11:12 UTC - Востановлены сервера в US East Coast, продолжается реплицирование. Налюдается повышенная нагрузка при реплицировании.</ul></li> <ul><li>2018.10.22 13:15 UTC - Приближались к пиковому периоду нагрузок. Увеличили количество репликаций для снятия растущей нагрузки по реклицированию.</ul></li> <ul><li>2018.10.22 16:24 UTC - После синхронизации реплик, выполнено переключение на исходную топологию MySQL</ul></li> <ul><li>2018.10.22 16:45 UTC - Балансировка нагрузки до восстановления 100% услуг клиентам. Для восстановления уже имеющихся данных пользователей включили обработку, так же подняли TTL до полного завершения восстановления и возвращения к штатной работе.</ul></li> <ul><li>2018.10.22 23:03 UTC - Работа возвращена к штатному поведению</ul></li>|
|Последующие действия| Собраны журналы MySQL по всем кластерам подвергнутых сбоя, производится анализ этих журналов и определение, какие записи могут быть согласованы автоматически, а какие требуют взаимодействия с пользователями. Запланированы инициативы: Настройка конфигурации Оркестратора для снижения рисков поведения, вызвавшего инцидент. Ускорен переход к новому механизму отчетности о статусе (больше информации о работе/не работе компонентов платформы). Запланировано изменение работы ЦОДОВ для возможности сохранения работоспособности при полной потере одного из ЦОДОВ в полнофункциональном состоянии, в том числе в переход на режим active/active/active. |
|Запланированы работы| <ul><li>Оптимизация работы Оркестратора для снижения рисков, которые могут привести к подобному случаю.</ul></li><ul><li>Изменение модели оповещения о статусе (более подробная информация о работе)</ul></li><ul><li>Запланировано мероприятие по изменению работы цодов, главной целью которого является возможность сохранения работоспособности все системы после потери одного из цодов.</ul></li>|