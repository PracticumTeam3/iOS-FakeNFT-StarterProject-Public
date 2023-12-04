Новиков Артем
<br /> Когорта: 6
<br /> Группа: 3
<br /> Эпик: Профиль

# Profile

## Module 1 (est: 22 h; fact: 23.5 h)

### Экран Профиль
- UI (est: 5 h; fact: 6 h):
	- Основная информация о пользователе - `avatar`, `name`, `description`, `website` (est: 2.5 h; fact: 3 h);
	- `TableView` для перехода на экраны `MyNFT`, `FavouriteNFT`, `About` (est: 2 h; fact: 2.5 h);
	- `NavBar` с кнопкой `Edit` (est: 0.5 h; fact: 0.5 h).
- Сеть и логика (est: 5 h; fact: 4.5 h):
	- Загрузка данных о пользователе (est: 4 h; fact: 4 h)
	- Открытие экрана `Редактировать профиль` (est: 1 h; fact: 0.5 h)

`Total:` est: 10 h; fact: 10.5 h.

#### Экран Редактировать профиль
- UI (est: 7 h; fact: 7 h):
	- `TextField` для полей `name`, `website` (est: 2 h; fact: 2 h);
	- `TextView` для поля `description` (est: 1.5 h; fact: 1.5 h);
	- `ImageView` для аватара с лейблом "Сменить фото" (est: 3 h; fact: 3 h);
	- Лейблы для полей и кнопка `Close` (est: 0.5 h; fact: 0.5 h).
- Сеть и логика (est: 5 h; fact: 6 h):
	- Изменение фото (est: 1.5 h; fact: 1.5 h);
	- Сохранение изменных данных о пользователе (est: 3 h; fact: 4 h);
	- Закрытие экрана (est: 0.5 h; fact: 0.5 h).

`Total:` est: 12 h; fact: 13 h.


## Module 2 (est: 17 h; fact: 18 h)
### Экран Мои NFT
- UI (est: 5 h; fact: 6 h):
	- `TableViewCell` (est: 2 h; fact: 4 h);
	- `TableView` (est: 2 h; fact: 1 h);
	- `NavBar` с кнопками `Back`, `Sort` и лейблом `Мои NFT` (est: 1 h; fact: 1 h).
- Сеть (est: 5 h; fact: 5 h):
	- Загрузка списка NFT (est: 5 h; fact: 5 h);
- Сортировка (est: 5 h; fact: 5 h):
	- Логика сортировки (est: 4 h; fact: 4 h);
	- `ActionSheet` (est: 1 h; fact: 1 h).
- Пустой экран (est: 2 h; fact: 2 h):
	- UI (пустой экран с лейблом и кнопкой `Back` в `NavBar` (est: 1 h; fact: 1 h);
	- Логика показа пустого экрана (est: 1 h; fact: 1 h).

## Module 3 (est: 17 h; fact: 15 h)
### Экран Избранные NFT
- UI (est: 5 h; fact: 5 h):
	- `CollectionViewCell` (est: 2 h; fact: 2 h);
	- `CollectionView` (est: 2 h; fact: 2 h);
	- `NavBar` с кнопкой `Back` и лейблом `Избранные NFT` (est: 1 h; fact: 1 h).
- Сеть (est: 10 h; fact: 8 h):
	- Загрузка списка NFT (est: 5 h; fact: 4 h);
	- Лайк (est: 5 h; fact: 4 h).
- Пустой экран (est: 2 h; fact: 2 h):
	- UI (пустой экран с лейблом и кнопкой `Back` в `NavBar` (est: 1 h; fact: 1 h);
	- Логика показа пустого экрана (est: 1 h; fact: 1 h).

## `Total:` est: 56 h; fact: 56.5 h.
