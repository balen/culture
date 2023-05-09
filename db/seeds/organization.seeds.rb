after :survey do

  p "End Organization seeds"

  # Test organizations
  # Assign survey to org
  unless Organization.count > 0
    organization = Organization.create!(
      name: "ACME Ltd."
    )
  end

  org = Organization.first

  if org.organization_surveys.count == 0
    survey = Survey.first
    org.organization_surveys.create!(
      survey: survey,
      access_code: 'ABCD'
    )
  end


  p "End Organization seeds"
end