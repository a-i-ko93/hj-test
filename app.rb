ENV['STAGE'] = 'development'

require './config'

synchronizer = Synchronizer.new
ap synchronizer.execute
