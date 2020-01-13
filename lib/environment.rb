require 'singleton'

class Environment
  include Singleton

  def plans_path
    File.join(slcsp_base_path, 'plans.csv')
  end

  def zips_path
    File.join(slcsp_base_path, 'zips.csv')
  end

  def slcsp_path
    File.join(slcsp_base_path, 'slcsp.csv')
  end

  def slcsp_base_path
    @slcsp_base_path ||= ENV['SLCSP_PATH'] || File.join('/Users/kevin', 'slcsp')
  end
end
