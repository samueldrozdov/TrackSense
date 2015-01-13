namespace :update_all_scores do
  task :update_scores do
    Submission.all.each do |submission|
      submission.score = (submission.likes - 1) / pow(((Time.zone.now - submission.created_at)/3600)+2, 1.8)
    end
  end
end
