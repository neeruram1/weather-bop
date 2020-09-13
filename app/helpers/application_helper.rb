module ApplicationHelper
  def us_states
    CS.states(:us)
  end

  def countries
    CS.get
  end
end
