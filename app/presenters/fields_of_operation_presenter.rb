class FieldsOfOperationPresenter < ContentItemPresenter
  include TitleAndContext
  include ContentsList

  def body
    "<h2 id='field-of-operation'>Field of operation</h2><p>UK forces are deployed to Afghanistan in support of the UN-authorised, NATO-led International Security Assistance Force (ISAF) mission and as part of the US-led Operation Enduring Freedom (OEF). Between 2003 and the end of 2014 UK operations in Afghanistan were conducted under the name Operation Herrick. Since then UK personnel have operated under the name Operation Toral.</p><h3 id=\"british-fatalities-in-afghanistan\">British fatalities in Afghanistan</h3><p>It is with very deep regret that the Ministry of Defence (<abbr title=\"Ministry of Defence\">MOD</abbr>) has confirmed the following fatalities suffered during operations in Afghanistan.</p><p>As at 23 July 2015, a total of 454 British forces personnel or <abbr title=\"Ministry of Defence\">MOD</abbr> civilians have died while serving in Afghanistan since the start of operations in October 2001.</p><p>Of these, 405 were killed as a result of hostile action.</p><p>49 are known to have died either as a result of illness, non-combat injuries or accidents, or have not yet officially been assigned a cause of death pending the outcome of an investigation. The balance of these figures may change as inquests are concluded.</p><p>Following a helicopter crash on 11 October 2015, 2 further UK personnel have died while serving in Afghanistan, taking the total number of military deaths to 456.</p><h2 id=\"fatalities\">Fatalities</h2>"
  end

  def title
    "Operations in Afghanistan"
  end

  def format
    'fields_of_operation'
  end
end
