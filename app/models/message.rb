class Message < ActiveRecord::Base
    scope :all_messages, lambda {|user, opponent| where("(origin = ? AND opponent = ?) OR (opponent = ? AND origin = ?)", user, opponent, user, opponent).order("created_at desc")}
    
    scope :update_messages, lambda {|user, opponent, start_date|  where("(created_at >= ? AND created_at <= ? AND origin = ? AND opponent = ?) OR (created_at >= ? AND created_at <= ? AND opponent = ? AND origin = ?)",start_date, Time.now.getlocal(), user, opponent, start_date, Time.now.getlocal(), user, opponent).order("created_at desc")}
    
    def as_json(options={})
        super(:only => [:origin, :opponent, :created_at])
    end
end
