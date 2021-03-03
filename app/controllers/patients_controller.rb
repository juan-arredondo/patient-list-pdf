class PatientsController < ApplicationController
  before_action :set_data

  def index
  end

  def show
    respond_to do |format|
      format.html
      format.pdf {render template: 'patients/patient_summary', pdf: 'Patient Summary', layout: 'pdf.html'}
    end

  end

  private

  def set_data
    @file = File.read('/Users/juan/Desktop/assignment/patient_sample/lib/assets/patient_list.json')
    @raw_data = JSON.parse(@file)
    @facility = @raw_data['facility'][0]
    @patient = @raw_data['patient'][0]
  end
end
