class PatientsController < ApplicationController
  def index
    file = File.read('/Users/juan/Desktop/assignment/patient_sample/app/assets/patient_list.json')
    raw_data = JSON.parse(file)
    facility = raw_data['facility'][0]
    patient = raw_data['patient'][0]

    @facility_name = facility['name']
    @first_name = patient['first_name']
    @middle_name = patient['middle_name']
    @last_name = patient['last_name']
    @mr = patient['mr']
  end

  def show
    file = File.read('/Users/juan/Desktop/assignment/patient_sample/app/assets/patient_list.json')
    raw_data = JSON.parse(file)
    facility = raw_data['facility'][0]
    patient = raw_data['patient'][0]

    @facility_name = facility['name']
    @first_name = patient['first_name']
    @middle_name = patient['middle_name']
    @last_name = patient['last_name']
    @mr = patient['mr']
    @dob = Date.parse(patient['dob'])
    @age = (((Date.today - @dob).to_i)/365.25).to_i
    @gender = patient['gender']

    @facility_name = facility['name']
    @admission_moment = DateTime.parse(patient['admission']['date']).strftime('%B %d, %Y, at %l:%M %p')

    @admission_diagnoses = patient['admission']['diagnoses']
    @admission_diagnoses_code = (@admission_diagnoses.map {|e| e['code']}).to_sentence
    @admission_diagnoses_description = (@admission_diagnoses.map {|e| e['description']}).to_sentence

    @admission_symptoms = patient['admission']['symptoms'].to_sentence

    @admission_observations = patient['admission']['observations'].to_sentence

    @allergies = patient['allergies'].to_sentence

    @chronic_conditions = patient['chronic_conditions']
    @chronic_conditions_description = (@chronic_conditions.map {|e| e['description']}).to_sentence
    @chronic_conditions_code = (@chronic_conditions.map {|e| e['code']}).to_sentence

    @medications = patient['medications'].map do |e|
      (e.values).to_sentence(words_connector: ' ',last_word_connector: ' to ')
    end
    @medication = @medications.to_sentence(two_words_connector: ', and ')

    @diagnostic_procedures = patient['diagnostic_procedures']
    @diagnostic_procedures_description = (@diagnostic_procedures.map {|e| e['description']}).to_sentence
    @diagnostic_procedures_moment = DateTime.parse(@diagnostic_procedures.map {|e| e['moment']}.to_sentence).strftime('%B %d, %Y, at %l:%M %p')

    @diagnoses = patient['diagnoses']
    @diagnoses_code = (@diagnoses.map {|e| e['code']}).to_sentence
    @diagnoses_description = (@diagnoses.map {|e| e['description']}).to_sentence

    @treatments = patient['treatments']
    @treatment = (@treatments.map {|e| e.values.join(' to ')}).to_sentence

    respond_to do |format|
      format.html
      format.pdf {render template: 'patients/patient_summary', pdf: 'Patient Summary', layout: 'pdf.html'}
    end

  end
end
