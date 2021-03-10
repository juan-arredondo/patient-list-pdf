module PatientsHelper

  def patient_age
    dob = Date.parse(@patient['dob'])
    (((Date.today - dob).to_i)/365.25).to_i
  end

  def admission_time
    DateTime.parse(@patient['admission']['date']).strftime('%B %d, %Y, at %l:%M %p')
  end

  def admission_diagnoses
    diagnoses = @patient['admission']['diagnoses']
    (diagnoses.map {|e| "#{e['description']} (#{e['code']})"}).to_sentence
  end

  def symptoms
    @patient['admission']['symptoms'].to_sentence
  end

  def observations
    @patient['admission']['observations'].to_sentence
  end

  def allergies
    @patient['allergies'].to_sentence
  end

  def chronic_conditions
    conditions = @patient['chronic_conditions']
    (conditions.map {|e| "#{e['description']} (#{e['code']})"}).to_sentence
  end

  def medications
    meds = @patient['medications']
    (meds.map { |e| "#{e['name']} #{e['dosage']}#{e['unit']} #{e['route']} #{e['frequency']} to #{e['necessity']}" }).to_sentence(two_words_connector: ', and ')
  end

  def diagnostic_procedures
    procedures = @patient['diagnostic_procedures']
    "#{(procedures.map {|e| e['description']}).to_sentence} on #{DateTime.parse(procedures.map {|e| e['moment']}.to_sentence).strftime('%B %d, %Y, at %l:%M %p')}"
  end

  def diagnoses
    diagnoses = @patient['diagnoses']
    (diagnoses.map {|e| "#{e['description']} (#{e['code']})"}).to_sentence(two_words_connector: ' and a ')
  end

  def treatments
    treatment = @patient['treatments']
    (treatment.map {|e| e.values.join(' to ')}).to_sentence
  end

end
