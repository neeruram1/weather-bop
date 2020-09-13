module ApplicationHelper
  def us_states
    CS.states(:us).invert
  end

  def countries
    CS.countries.invert
  end
end
