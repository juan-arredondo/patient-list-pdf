module PatientsHelper

  def patient_age
    dob = Date.parse(@patient['dob'])
    (((Date.today - dob).to_i)/365.25).to_i
  end

  def admission_diagnoses
    diagnoses = @patient['admission']['diagnoses']
    "#{(diagnoses.map {|e| e['description']}).to_sentence} (#{(diagnoses.map {|e| e['code']}).to_sentence})"
  end

  def chronic_conditions
    conditions = @patient['chronic_conditions']
    "#{(conditions.map {|e| e['description']}).to_sentence} (#{(conditions.map {|e| e['code']}).to_sentence})"
  end

  def medications
    meds = @patient['medications'].map {|e| (e.values).to_sentence(words_connector: ' ',last_word_connector: ' to ')}
    meds.to_sentence(two_words_connector: ', and ')
  end

  def diagnostic_procedures
    procedures = @patient['diagnostic_procedures']
    "#{(procedures.map {|e| e['description']}).to_sentence} on #{DateTime.parse(procedures.map {|e| e['moment']}.to_sentence).strftime('%B %d, %Y, at %l:%M %p')}"
  end

  def diagnoses
    diagnoses = @patient['diagnoses']
    "#{(diagnoses.map {|e| e['description']}).to_sentence} (#{(diagnoses.map {|e| e['code']}).to_sentence})"
  end

  def treatments
    treatment = @patient['treatments']
    (treatment.map {|e| e.values.join(' to ')}).to_sentence    
  end

end
