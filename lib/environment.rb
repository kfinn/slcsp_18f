require 'singleton'

class Environment
  include Singleton

  def plans_path
    File.join(slcsp_path, 'plans.csv')
  end

  def slcsp_path
    @slcsp_path ||= ENV['SLCSP_PATH'] || File.join('~', 'slcsp')
  end
end
