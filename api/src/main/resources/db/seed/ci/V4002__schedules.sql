INSERT INTO `threepl`.`schedule`
  (
    case_number,
    facility_id,
    surg_area,
    surg_or,
    pre_op_diagnosis,
    procedure_desc,
    procedure_date,
    status,
    status_reason,
    primary_surgeon_id,
    primary_surgeon_name,
    patient_name,
    patient_dob,
    patient_mrn,
    creation_user
  )
VALUES
  (
    "cn123",
    1,
    "HOSPFHNCOR",
    "HOSPFHNCOR1",
    "heart needs fixed",
    "fixed dat heart",
    "2017-3-17T08:00:00.000",
    10,
    "scheduled",
    "surg123",
    "Dr. Surgeon",
    "King, Molly",
    "1970-6-30",
    "123456789",
    "flyway"
  ),
  (
    "cn456",
    2,
    "HOSPFHNCOR",
    "HOSPFHNNOR2",
    "brain needs fixed",
    "fixed dat brain",
    "2017-3-17T08:15:00.000",
    10,
    "scheduled",
    "surg456",
    "Dr. Sturgeon",
    "Taylor, James",
    "1930-7-1",
    "987654321",
    "flyway"
  );
