Factory.define :topic do |topic|
  topic.title "Hello"
  topic.content "World!"
end

Factory.define :reply do |reply|
  reply.content "Foo bar"
  reply.association :topic
end
