# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admins =
  [
    {email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD']},
  ]

admins.each do |admin|
  admin_data = Admin.find_by(email: admin[:email])
  if admin_data.nil?
    puts "#{admin[:email]}追加"
    Admin.create([
        email: admin[:email],
        password: admin[:password]
      ])
  end
end

members =
  [
    {
      email: 'user1@example.com', password: 'passw@rd',
      name: '本次郎', nick_name: 'タカタカ',
      self_introduction: '新しい発見をしたいです、よろしくお願いします',
      is_deleted: false,
    },
    {
      email: 'user2@example.com', password: 'passw@rd',
      name: '文庫太郎', nick_name: '文太',
      self_introduction: '自分の好きな本を紹介していきたいと思います、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user3@example.com', password: 'passw@rd',
      name: '文矢華津', nick_name: '文',
      self_introduction: '矢文大好きで古文系を読んでます、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user4@example.com', password: 'passw@rd',
      name: 'テスト次郎', nick_name: 'テス次',
      self_introduction: '問題解決系の本を読みます、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user5@example.com', password: 'passw@rd',
      name: 'テスト太郎', nick_name: 'テス郎',
      self_introduction: 'よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user6@example.com', password: 'passw@rd',
      name: 'テスト花子', nick_name: 'テス子',
      self_introduction: '自分の好きな本を紹介していきたいと思います、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user7@example.com', password: 'passw@rd',
      name: 'テスト文子', nick_name: 'テス文',
      self_introduction: '自分の好きな本を紹介していきたいと思います、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user8@example.com', password: 'passw@rd',
      name: '文庫テスト', nick_name: '文ト',
      self_introduction: 'よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user9@example.com', password: 'passw@rd',
      name: '文太次', nick_name: 'タジ',
      self_introduction: '好きな本を増やしていきたいです、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user10@example.com', password: 'passw@rd',
      name: '庫太郎', nick_name: '風魔',
      self_introduction: '忍びについて文献をあさってます、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user11@example.com', password: 'passw@rd',
      name: '庫次郎', nick_name: '佐々木',
      self_introduction: '剣豪についての本が好きです、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user12@example.com', password: 'passw@rd',
      name: '庫文次郎', nick_name: '虎狼',
      self_introduction: '狼の題材が好きです、よろしくお願いします',
      is_deleted: false
    },
    {
      email: 'user13@example.com', password: 'passw@rd',
      name: '古文テス子', nick_name: 'フルイ',
      self_introduction: '古文を広めていきたいです、よろしくお願いします',
      is_deleted: false
    },
  ]

members.each do |member|
  member_data = Member.find_by(email: member[:email])
  if member_data.nil?
    puts "#{member[:email]}追加"
    Member.create([
        email: member[:email],
        password: member[:password],
        name: member[:name],
        nick_name: member[:nick_name],
        self_introduction: member[:self_introduction],
        is_deleted: member[:is_deleted]
      ])
  end
end

isbns =
  [
    {email: 'user1@example.com', isbn: '9784297124373'},
    {email: 'user1@example.com', isbn: '9784297114626'},
    {email: 'user1@example.com', isbn: '9784297101237'},
    {email: 'user1@example.com', isbn: '9784839962227'},
    {email: 'user1@example.com', isbn: '9784798168845'},
    {email: 'user1@example.com', isbn: '9784797399844'},
    {email: 'user1@example.com', isbn: '9784295008057'},
    {email: 'user1@example.com', isbn: '9784798160689'},
    {email: 'user1@example.com', isbn: '9784774195025'},
    {email: 'user2@example.com', isbn: '9784774195025'},
    {email: 'user2@example.com', isbn: '9784839962227'},
    {email: 'user2@example.com', isbn: '9784798168845'},
    {email: 'user2@example.com', isbn: '9784797399844'},
    {email: 'user2@example.com', isbn: '9784295008057'},
    {email: 'user2@example.com', isbn: '9784798160689'},
    {email: 'user3@example.com', isbn: '9784798168494'},
    {email: 'user3@example.com', isbn: '9784877835026'},
    {email: 'user3@example.com', isbn: '9784569764542'},
    {email: 'user3@example.com', isbn: '9784569766348'},
    {email: 'user3@example.com', isbn: '9784865940657'},
    {email: 'user3@example.com', isbn: '9784798060996'},
    {email: 'user3@example.com', isbn: '9784295007678'},
    {email: 'user3@example.com', isbn: '9784897978857'},
    {email: 'user3@example.com', isbn: '9784297124373'},
    {email: 'user3@example.com', isbn: '9784396792183'},
    {email: 'user4@example.com', isbn: '9784798168494'},
    {email: 'user5@example.com', isbn: '9784774195025'},
    {email: 'user6@example.com', isbn: '9784295012863'},
    {email: 'user7@example.com', isbn: '9784297114688'},
    {email: 'user8@example.com', isbn: '9784865940657'},
    {email: 'user9@example.com', isbn: '9784798060996'},
    {email: 'user10@example.com', isbn: '9784295007678'},
    {email: 'user11@example.com', isbn: '9784897978857'},
    {email: 'user12@example.com', isbn: '9784297124373'},
    {email: 'user12@example.com', isbn: '9784396792183'},
  ]

isbns.each do |isbn|
  member = Member.find_by(email: isbn[:email])
  find_book = Book.find_by(member_id: member.id, isbn: isbn[:isbn])

  if find_book.nil?
    rws_book = RakutenWebService::Books::Book.search(isbn: isbn[:isbn]).first

    genre_result = RakutenWebService::Books::Genre.search(booksGenreId: rws_book.books_genre_id.split("/").first).first
    genre = Genre.find_or_initialize_by(books_genre_id: genre_result["booksGenreId"])
    if genre.new_record?
      genre.name = genre_result["parents"][0]["booksGenreName"]
      genre.save!
    end

    Book.find_or_create_by(member_id: member.id, isbn: isbn[:isbn]) do |book|
        book.title = rws_book.title
        book.author = rws_book.author
        book.publisher_name = rws_book.publisher_name
        book.image_url = rws_book.large_image_url
        book.genre_id = genre.id
    end

    puts "#{member.name}のために#{rws_book.title}を取得"
  end

end

m = Member.find_by(email: isbns[0][:email])
book_content = Book.find_by(member_id: m.id, isbn: isbns[0][:isbn])
book_content.catchphrase = "Rubyが実践で使えるようになる"
book_content.body = "Rubyの勉強に使用してます。rubyの理解が少しできるときに見たほうが参考にしやすいと思います"
book_content.save!
comments =
  [
    {member: Member.find_by(email: members[1][:email]), comment: 'よくできたためになる本'},
    {member: Member.find_by(email: members[2][:email]), comment: '勉強できました'},
    {member: Member.find_by(email: members[3][:email]), comment: '使える１冊'},
  ]

comments.each do |c|
  book_content.post_comments.new(member: c[:member], comment: c[:comment]).save
end

m = Member.find_by(email: isbns[3][:email])
book_content = Book.find_by(member_id: m.id, isbn: isbns[3][:isbn])
book_content.catchphrase = "Ruby初心者のおすすめ"
book_content.body = "rubyが初めてで不安でしたがわかりやすい内容と説明でしたのでRubyの勉強に使用してます。"
book_content.save!
comments =
  [
    {member: Member.find_by(email: members[5][:email]), comment: '初心者の自分には難しかったです。'},
    {member: Member.find_by(email: members[9][:email]), comment: '自分も使用してます。'},
    {member: Member.find_by(email: members[12][:email]), comment: '自分も買いたいと思います。'},
  ]

comments.each do |c|
  book_content.post_comments.new(member: c[:member], comment: c[:comment]).save
end