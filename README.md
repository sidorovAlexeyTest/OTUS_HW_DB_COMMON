# OTUS_HW_DB_COMMON
Репозиторий для домашних заданий ОТУС Базы Данных. Общие сведения.

### Диграмма для базы данных застройщиков, их объектов и покупателей.

![диаграмма](https://github.com/sidorovAlexeyTest/OTUS_HW_DB_COMMON/blob/main/img/postgres%20-%20otus_hw_1.png)
В качестве основной СУБД выбрана postgres 15

### Бизнес цель: Создание сайта агрегатора для покупки и продажи квартир.
> Для справки про табличку **"buyer"**. Так как строение БД довольно простое, именно для обучения, была добавлена табличка **"buyer"** имеющая связь *ManyToMany*.
* **"housing_complex"** - информация о застройщике
* **"house"** - информация о здании
* **"hb_object"** - информация об объекте продажи(квартира)
* **"object_space"** - информация об участвках объекта(комната, коридор, ванная комната...)
* **"buyer"** - информация о покупателе
* **"buyer_hb_object_link"** - линковочная таблица для связки покупатель-объект
* **_type** и **_status** - таблицы типов и статусов. Для каждого объекта свои типы и статусы для соблюдения консистентности данных.

### Добавлены следующие индексы в для базы данных.
![индексы](https://github.com/sidorovAlexeyTest/OTUS_HW_DB_COMMON/blob/hw_2/add_index/img/index.jpg)
