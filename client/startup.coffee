Meteor.startup ->
  Session.setDefault('ready', false)
  Meteor.subscribe("Groups", -> Session.set('ready', true))
  Meteor.subscribe('Items')
  Meteor.subscribe('Tries')
  
  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'
  
  
  i18n.map 'cn', 
    Hello: '你好'
    "Discuss": "讨论"
    "Welcome, Test your English here!": "你好，测试你的英语水平"
    "Create a test": "创建测试"
    "Create": "创建"
    "Please login/register first": "请先登录​​或注册, 用Sign in"
    "others have tried this test": "人试过了这个测试"
    "You tried this test": "你试过了这个测试"
    "times": "次"
    "You haven't tried this test yet": "你还没试过了这个测试"
    "Correct answers": "对的回答"
    "of total answers": "of total answers"
    "Total questions": "问题"
    "Stop Test": "结束"
    "Please stop your current test before starting a new one": "请先结束现在的测试再开始一个新的"
    "Start Test": "开始"
    "Add question": "加问题"
    "Answer choices": "回答选"
    "Add choice": "加选择"
    "Correct answer": "对的回答"
    "Create Question": "创建问题"
    "Well done": "对的"
    "Wrong answer": "错的"
    "Your answer": "你的回答"
    "Sorry wrong answer, this is the correct answer": "不好意思，是错的，这是对的回答"
    "Choose an answer": "选回答"
    "Choose": "选"
    "Please choose a Test": "请选一个测试"
  
  i18n.map 'en', 
    Hello: 'Hello'
    "Discuss": "Discuss"
    "Welcome, Test your English here!": "Welcome, Test your English here!"
    "Create a test": "Create a Test"
    "Create": "Create"
    "Please login/register first": "Please login/register first"
    "others have tried this test": "others have tried this test"
    "You tried this test": "You tried this test"
    "times": "times"
    "You haven't tried this test yet": "You haven't tried this test yet"
    "Correct answers": "Correct answers"
    "of total answers": "of total answers"
    "Total questions": "Total questions"
    "Stop Test": "Stop Test"
    "Please stop your current test before starting a new one": "Please stop your current test before starting a new one"
    "Start Test": "Start Test"
    "Add question": "Add question"
    "Answer choices": "Answer choices"
    "Add choice": "Add choice"
    "Correct answer": "Correct answer"
    "Create Question": "Create Question"
    "Well done": "Well Done"
    "Wrong answer": "Wrong answer"
    "Your answer": "Your answer"
    "Sorry wrong answer, this is the correct answer": "Sorry wrong answer, this is the correct answer"
    "Choose an answer": "Choose an answer"
    "Choose": "Choose"
    "Please choose a Test": "Please choose a Test"

  
  i18n.setLanguage('en')