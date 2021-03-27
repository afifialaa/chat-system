class Message < ApplicationRecord
    belongs_to :chat, :counter_cache => :messages_count

    validates :body, presence: true
    validates :num, presence: true, uniqueness: true
    validates :chat_id, presence: true

    # Setting Message as elasticsearch type
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name "chat-app"
    document_type "message"

    settings index: { number_of_shards: 1 } do
        mapping dynamic: false do
          indexes :body, analyzer: 'english'
        end
    end

    def as_indexed_json(options = nil)
        self.as_json( only: [ :body, :chat_id] )
    end

    def self.search_messages(query, chat_id)
        puts chat_id
        self.search({
            query: {
                bool: {
                    must: [
                        {
                            multi_match: {
                                query: query,
                                fields: [:body]
                            }
                        },
                        match: {
                            chats_id: chat_id
                        }
                        
                    ]
                }
            }
        })
    end
end
