Кудряшов Александр Витальевич
<br /> Кагорта: 6
<br /> Группа: 3
<br /> Эпик: Корзина
<br /> Архитектура: MVVM
<br /> Верстка: кодом
<br /> Таск-трекер: https://github.com/orgs/PracticumTeam3/projects/1/views/1

<hr>

# Cart Flow Decomposition

## Экран Cart (est 1680 min; fact 1500 min).
### Module 1:

#### Верстка экрана Корзины
- вьюМодель для ячейки (est: 60 min; fact: 60 min).
- вьюМодель для главного экрана (est: 60 min; fact: 60 min).
- моковые данные для UItableView (est: 60 min; fact: 60 min).
- основной вью и переход на него в коде (est: 60 min; fact: 60 min).
- UITableViewCell (est: 240 min; fact: 240 min).
- UITableView (est: 240 min; fact: 180 min).
- добавление нестандартной кнопки сортировка (est: 60 min; fact: 60 min).
- вью с кнопкой оплатить (est: 60 min; fact: 60 min).
- вью пустой корзины (est: 60 min; fact: 60 min).

`Total:` est: 1020 min; fact: 960 min.

#### Верстка алерт контроллера Удалить
- настройка недефолтного алерта (est: 360 min; fact: 300 min).

`Total:` est: 360 min; fact: 300 min.

#### Логика
- удаление из корзины (без сетевого запроса) (est: 60 min; fact: 60 min).
- сортировка корзины (est: 60 min; fact: 60 min).
- логика отображения итогового значения оплатить или пустой корзины (est: 120 min; fact: 90 min).
- сохранить способ сортировки в UserDefaults (est: 60 min; fact: 30 min).

`Total:` est: 300 min; fact: 240 min.

## Экран Способ оплатить (est 1230; fact 1470).

### Module 2:
#### Верстка экрана способ олпатить
- вьюМодель для ячейки(est: 60 min; fact: 60 min).
- вью модель для коллекции (est: 60 min; fact: 120 min).
- CollectionViewCell (est: 180 min; fact: 120 min).
- CollectionView (est: 180 min; fact: 180 min).
- кнопка Оплатить и пользовательское согласшение (est: 60 min; fact: 150 min).

`Total:` est: 540 min; fact: 630 min.

#### Логика
- сетевой запрос на получение корзины (est: 240 min; fact: 240 min)
- сетевой запрос на удаление из корзины (est: 180 min; fact: 300 min)
- выбор ячейки оплаты (est: 60 min; fact: 60 min).
- нажатие на кнопку (est: 30 min; fact: 60 min).
- сетевой запрос на покупку (est: 180 min; fact: 180 min).

`Total:` est: 690 min; fact: 840 min.

## Настройка сетевого слоя (est 900; fact 840).

### Module 3:
#### Верстка экрана результат оплаты
- экран вебвью с пользовательским соглашение (est: 300 min; fact: 300 min).
- вьюМодель для экрана результат оплаты (est: 60 min; fact: 60 min).
- вью результат оплаты (est: 60 min; fact: 60 min).
- алертМодель с неудачной оплатой (est: 60 min; fact: 60 min).

`Total:` est: 480 min; fact: 480 min.

#### Логика
- обработка сетевого ответа (est: 60 min; fact: 60 min).
- нажатие на кнопку (est: 60 min; fact: 60 min).
- проверка проекта и доработка ошибок (est: 300 min; fact: 240 min).

`Total:` est: 420 min; fact: 360 min.
