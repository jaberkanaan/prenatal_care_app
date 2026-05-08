/// 11-Visit Prenatal Schedule based on Barwon Health Protocol
/// Used for tracking and scheduling prenatal visits during pregnancy

const List<Map<String, dynamic>> prenatalVisits = [
  {
    'visit': 1,
    'label': 'Confirmation of Pregnancy (GP)',
    'weeks': 'Early',
    'weekNumber': 0,
    'investigations': [
      'Urine pregnancy test / β-hCG',
      'Blood group & Rh factor',
      'Full Blood Count (FBC)',
      'Rubella immunity',
      'Hepatitis B surface antigen',
      'HIV screening',
      'Syphilis (VDRL/RPR)',
      'Down syndrome/genetic screening (NIPT/First Trimester Screen)',
      'Pap smear if due',
    ],
    'advice':
        'Confirm pregnancy, start folic acid 400–800 mcg/day, avoid alcohol/smoking, register with maternity clinic.',
  },
  {
    'visit': 2,
    'label': 'First Antenatal Visit',
    'weeks': '12–16',
    'weekNumber': 12,
    'investigations': [
      'Review blood results',
      'Blood pressure & pulse',
      'Weight & BMI',
      'Urine dipstick (protein, glucose)',
      'Discuss genetic screening if not done',
      'Nuchal translucency ultrasound (if 11–13+6 wks)',
    ],
    'advice':
        'Discuss care model, start iron if FBC low, book morphology scan at 18–20 weeks.',
  },
  {
    'visit': 3,
    'label': 'Morphology Ultrasound',
    'weeks': '18–20',
    'weekNumber': 18,
    'investigations': [
      'Anatomy ultrasound (fetal morphology)',
      'Placenta location',
      'Amniotic fluid index (AFI)',
      'Fetal biometry: BPD, HC, AC, FL',
    ],
    'advice':
        'Review results for structural anomalies. Check placental site — note if low-lying.',
  },
  {
    'visit': 4,
    'label': 'Mid-Pregnancy Review',
    'weeks': '20–22',
    'weekNumber': 20,
    'investigations': [
      'Blood pressure',
      'Fundal height measurement',
      'Fetal heart rate',
      'Review ultrasound findings',
      'Order OGTT (to be done at 26–28 wks)',
    ],
    'advice':
        'Discuss fetal movements, iron/calcium supplements, dental check, sleep position (left lateral).',
  },
  {
    'visit': 5,
    'label': '28-Week Visit',
    'weeks': '28',
    'weekNumber': 28,
    'investigations': [
      'OGTT results (Gestational Diabetes screening)',
      'Full Blood Count (FBC) — anaemia check',
      'Anti-D immunoglobulin if Rh negative',
      'Blood pressure',
      'Fundal height',
      'Urinalysis',
    ],
    'advice':
        'If GDM diagnosed: diet counselling, glucose monitoring. Iron supplementation if Hb < 10.5 g/dL.',
  },
  {
    'visit': 6,
    'label': '31-Week Visit (Prior C/S)',
    'weeks': '31',
    'weekNumber': 31,
    'investigations': [
      'Blood pressure',
      'Fundal height',
      'Fetal presentation',
      'Review previous caesarean scar (if applicable)',
      'Urinalysis',
    ],
    'advice':
        'Discuss birth plan for women with prior caesarean section. Assess VBAC eligibility.',
  },
  {
    'visit': 7,
    'label': '34-Week Visit',
    'weeks': '34',
    'weekNumber': 34,
    'investigations': [
      'Blood pressure',
      'Fundal height',
      'Fetal presentation',
      'GBS swab (given for self-use at 36 weeks)',
      'Anti-D if Rh negative (second dose)',
      'Discuss induction of labour options',
    ],
    'advice':
        'Teach signs of labour, prepare hospital bag, review birth plan, discuss breastfeeding.',
  },
  {
    'visit': 8,
    'label': '36-Week Visit',
    'weeks': '36',
    'weekNumber': 36,
    'investigations': [
      'Blood pressure',
      'Fundal height',
      'Fetal presentation (Leopold\'s)',
      'GBS swab result',
      'Urinalysis',
      'Fetal heart rate',
    ],
    'advice':
        'Confirm fetal head engagement, finalise birth plan, review GBS status for intrapartum antibiotic prophylaxis.',
  },
  {
    'visit': 9,
    'label': '38-Week Visit',
    'weeks': '38',
    'weekNumber': 38,
    'investigations': [
      'Blood pressure',
      'Fundal height',
      'Fetal presentation & station',
      'Fetal heart rate',
      'Urinalysis',
      'Membrane sweep discussion',
    ],
    'advice':
        'Discuss membrane sweep, signs of labour, when to go to hospital (contraction timing).',
  },
  {
    'visit': 10,
    'label': '40-Week Visit',
    'weeks': '40',
    'weekNumber': 40,
    'investigations': [
      'Blood pressure',
      'Fundal height',
      'Fetal heart rate',
      'Cardiotocography (CTG) if indicated',
      'Urinalysis',
      'Second membrane sweep offer',
    ],
    'advice':
        'Discuss induction of labour at 41 weeks if not delivered. Monitor fetal movements closely.',
  },
  {
    'visit': 11,
    'label': '41-Week Visit',
    'weeks': '41',
    'weekNumber': 41,
    'investigations': [
      'Blood pressure',
      'CTG monitoring',
      'Ultrasound: AFI & fetal wellbeing',
      'Bishop score (cervical assessment)',
      'Urinalysis',
    ],
    'advice':
        'Schedule induction of labour. Risk of stillbirth increases after 41 weeks — discuss with doctor.',
  },
];

/// Get visit data by visit number
Map<String, dynamic>? getVisitByNumber(int visitNumber) {
  try {
    return prenatalVisits.firstWhere((v) => v['visit'] == visitNumber);
  } catch (e) {
    return null;
  }
}

/// Get current recommended visit based on gestational weeks
Map<String, dynamic>? getVisitForWeeks(int weeks) {
  if (weeks < 12) return prenatalVisits[0]; // Visit 1
  if (weeks < 18) return prenatalVisits[1]; // Visit 2
  if (weeks < 20) return prenatalVisits[2]; // Visit 3
  if (weeks < 22) return prenatalVisits[3]; // Visit 4
  if (weeks < 31) return prenatalVisits[4]; // Visit 5
  if (weeks < 34) return prenatalVisits[5]; // Visit 6
  if (weeks < 36) return prenatalVisits[6]; // Visit 7
  if (weeks < 38) return prenatalVisits[7]; // Visit 8
  if (weeks < 40) return prenatalVisits[8]; // Visit 9
  if (weeks < 41) return prenatalVisits[9]; // Visit 10
  return prenatalVisits[10]; // Visit 11
}

/// Get all visits up to a certain week
List<Map<String, dynamic>> getVisitsUpToWeeks(int weeks) {
  return prenatalVisits.where((v) => v['weekNumber'] <= weeks).toList();
}
