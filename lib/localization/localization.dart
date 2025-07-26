class Localization {
  static Map localizationData = {
    'ru': {
      'loginScreen': {
        'title': 'Войти',
        'login': 'email',
        'password': 'Пароль',
        'goButton': 'Войти',
        'registrationButton': 'Регистрация',
        'emailValidate': 'Несуществующий Email',
        'passwordValidate': 'Минимальная длина пароля 6 символов',
        'loginSuccess': 'Успешная аутентификация'
      },
      'registrationScreen': {
        'title': 'Регистрация',
        'login': 'Имя',
        'email': 'Email',
        'password': 'Пароль',
        'rePassword': 'Повтор пароля',
        'goButton': 'Зарегистрироваться',
        'back': 'Назад',
        'userNameValidate': 'Не менее 3 символов без пробелов',
        'emailValidate': 'Несуществующий Email',
        'passwordValidate': 'Минимальная длина пароля 6 символов',
        'rePasswordValidate': 'Пароли не совпадают',
        'registrationSuccess': 'Вы успешно зарегистрировались',
        'modalButtonLogin': 'Войти',
        'modalErrorButtonLogin': 'Попробовать ещё'
      },
      'createChatScreen': {
        'title': 'Создать чат',
        'nameUser': 'Имя пользователя',
        'findUsers': 'Найденные пользователи:',
        'members': 'Участники:',
        'nameChat': 'Название чата',
        'goButton': 'Создать',
        'notFound': 'Пользователи не найдены',
        'notFoundChatName': 'Укажите название беседы',
        'userName': 'Имя: ',
        'add': 'Добавить'
      },
      'createPostScreen': {
        'title': 'Новая запись',
        'body': 'Текст',
        'tags': 'теги',
        'goButton': 'Создать',
      },
      'messageScreen': {
        'delivered': 'доставлено',
        'removeChat': 'Удалить чат',
        'deleteDialog': 'Вся информация из диалога будет удалена. Вы уверены?',
        'back': 'Назад',
        'accept': 'Подтвердить',
        'paste': 'Вставить из буфера',
        'forwarded': 'Оригинальное сообщение'
      },
      'allChatScreen': {
        'newMessage': 'Новое сообщение',
        'settings': 'Настройки',
        'profile': 'Мой профиль',
        'groups': 'Группы'
      },
      'settingsScreen': {
        'language': 'Язык приложения',
        'selectServer': 'Выбор сервера',
        'deleteServer': 'Подтверждаете удаление сервера?',
        'exampleServer': 'Пример: 0.0.0.0:4400',
        'notification': 'Уведомления',
        'send': 'Отправка по ctrl+enter',
        'color': 'Выбрать цвет',
        'select': 'Выбрать',
        'addLocalPass': 'Задать пароль на приложение',
        'pickBackground': 'Выбрать фон'
      },
      'addLocalPass': {
        'localPass': 'Пароль приложения',
        'add': 'Задать',
        'success': 'Пароль успешно установлен',
      },
      'editGroupScreen': {
        'title': 'Редактировать диалог',
        'nameUser': 'Имя пользователя',
        'findUsers': 'Поиск пользователя:',
        'members': 'Участники:',
        'nameChat': 'Название чата',
        'goButton': 'Сохранить',
        'back': 'Назад',
        'notFound': 'Пользователи не найдены',
        'notFoundChatName': 'Укажите название беседы',
        'userName': 'Имя: ',
        'groupImage': 'Загрузить изображение'
      },
      'notification': {'newMessage': 'Новое сообщение'}
    },
    'en': {
      'loginScreen': {
        'title': 'Login',
        'login': 'Email',
        'password': 'Password',
        'goButton': 'To come in',
        'registrationButton': 'Registration',
        'emailValidate': 'Defunct Email',
        'passwordValidate': 'Minimum password length 6 characters',
        'loginSuccess': 'Successful authentication'
      },
      'registrationScreen': {
        'title': 'Registration',
        'login': 'Name user',
        'email': 'Email',
        'password': 'Password',
        'rePassword': 'Repeat password',
        'goButton': 'Registration',
        'back': 'Back',
        'userNameValidate': 'At least 3 characters without spaces',
        'emailValidate': 'Defunct Email',
        'passwordValidate': 'Minimum password length 6 characters',
        'rePasswordValidate': 'Password mismatch',
        'registrationSuccess': 'Successful registration',
        'modalButtonLogin': 'Go to login',
        'modalErrorButtonLogin': 'Try again'
      },
      'createChatScreen': {
        'title': 'Create chat',
        'nameUser': 'Name user',
        'findUsers': 'Find users:',
        'members': 'Members:',
        'nameChat': 'Name chat',
        'goButton': 'Create',
        'notFound': 'Users not found',
        'notFoundChatName': 'Enter a name for the conversation',
        'userName': 'User name: ',
        'add': 'Add'
      },
      'createPostScreen': {
        'title': 'New post',
        'body': 'body',
        'tags': 'tags',
        'goButton': 'Create',
      },
      'messageScreen': {
        'delivered': 'delivered',
        'removeChat': 'Delete chat',
        'deleteDialog':
            'All information from the dialog will be deleted. Are you sure?',
        'back': 'Back',
        'accept': 'Accept',
        'paste': 'Paste on clipboard',
        'forwarded': 'Original message'
      },
      'allChatScreen': {
        'newMessage': 'New message',
        'settings': 'Settings',
        'profile': 'My profile',
        'groups': 'Groups'
      },
      'settingsScreen': {
        'language': 'language',
        'selectServer': 'Server selection',
        'deleteServer': 'Do you confirm deleting the server?',
        'exampleServer': 'Example: 0.0.0.0:4400',
        'notification': 'Notification',
        'send': 'Send to ctrl+enter',
        'color': 'Pick color',
        'select': 'Select',
        'addLocalPass': 'Set a password for the application',
        'pickBackground': 'Pick Background'
      },
      'editGroupScreen': {
        'title': 'Edit chat',
        'nameUser': 'Name user',
        'findUsers': 'Find users:',
        'members': 'Members:',
        'nameChat': 'Name chat',
        'goButton': 'Save',
        'back': 'Back',
        'notFound': 'Users not found',
        'notFoundChatName': 'Enter a name for the conversation',
        'userName': 'User name: ',
        'groupImage': 'Add image'
      },
      'notification': {
        'newMessage': 'New message'},
      'addLocalPass': {
        'localPass': 'Local Password',
        'add': 'Set password',
        'success': 'Password set successfully',
      }
    }
  };
}
