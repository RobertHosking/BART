class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.integer :dataset_id
      t.string :employeeNo
      t.string :evaluatorNo
      t.string :positionName
      t.string :smartEvalsPositionID
      t.string :companyPositionID
      t.string :division
      t.string :dept
      t.string :departmentLong
      t.string :positionNum
      t.string :wlsLevel
      t.integer :positionLevel
      t.string :positionTrait
      t.integer :positionYear
      t.string :positionSemester
      t.integer :positionSection
      t.string :evaluateeFirstName
      t.string :evaluateeMiddleName
      t.string :evaluateeLastName
      t.string :surveyBeginDate
      t.string :surveyEndDate
      t.string :surveyCompleteDate
      t.string :employeeOrPostion?
      t.integer :i40355
      t.integer :i40367
      t.integer :i40360
      t.integer :i40370
      t.integer :i40372
      t.integer :i40375
      t.integer :i40378
      t.integer :i59526
      t.text :attendance
      t.text :accountability
      t.text :teamwork
      t.text :initiative
      t.text :respect
      t.text :learning
      t.text :jobSpecific
      t.string :s40874
      t.string :s40875
      t.string :s65452
      t.string :s65453
      t.string :raceOfSupervisor
      t.string :gender
      t.integer :age
      t.string :esl
      t.string :partTimeFullTime
      t.string :creditHours
      t.string :positionStatus
      t.string :instructorTenured
      t.string :major
      t.string :gradeID
      t.string :advisorBnum
      t.string :advisorLastName
      t.string :transferStudent
      t.string :inState
      t.string :gpaSoFar
      t.integer :weekDropped
      t.string :timeline
      t.timestamps
    end
  end
end
