every 6.hours do
  runner "DistributableJackpot.mark_as_distributed"
end

every 2.minutes do
  runner "DistributableJackpot.update_jackpot"
end