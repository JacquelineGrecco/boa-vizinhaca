module UtilTestConstants
  EXPECTED_DATE_FORMAT = 'data_formats.date'
  EXPECTED_FILE_FORMAT = 'data_formats.file'
  EXPECTED_INTEGER_FORMAT = 'data_formats.integer'
  EXPECTED_BOOLEAN_FORMAT = 'data_formats.boolean'
  EXPECTED_HASH_FORMAT = 'data_formats.hash'
  EXPECTED_CPF_FORMAT = 'data_formats.cpf'
  EXPECTED_CNPJ_FORMAT = 'data_formats.cnpj'
  EXPECTED_DOCUMENT_FORMAT = 'data_formats.document'
  EXPECTED_EMAIL_FORMAT = 'data_formats.email'
  EXPECTED_JUSTIFICATION_FORMAT = 'data_formats.justification'
  EXPECTED_NUMBER_FORMAT = 'data_formats.number'
  EXPECTED_POSITIVE_NUMBER_FORMAT = 'data_formats.positive_number'
  EXPECTED_STRING_FORMAT = 'data_formats.string'

  VALID_DATES = %w(1994-04-18 2020-02-29)
  VALID_INTEGERS = [-31, +13, 0, 23747263847234638, -23747263847234638]
  VALID_NUMBERS = VALID_INTEGERS + [0.0, 1.1, -5.1, 5.123123123145, -2.12312312566]
  VALID_STRINGS = ['This should be valid', 'This too']
  VALID_BOOLEANS = [true, false, 1, 0, 'true', 'false', 'trUE', 'fAlsE']
  VALID_HASHES = [{}, {a: 1}, {'b' => 1}]
  VALID_CPFS = ['866.273.221-61', '522-372.648-05', '64373773726', '522.372.648-05', 64373773726, '00000000191']
  VALID_CNPJS = ['66.873.046/0001-23', '88.359.811/0001-24', '38831216000171', 38831216000171]
  FORMATTED_CNPJ = '66.873.046/0001-23'
  FORMATTED_CPF = '866.273.221-61'
  VALID_EMAILS = ['valid_email@abc.com', 'should@be.valid']
  POSITIVE_NUMBERS = [0.1, 1.0, 1, 2, 7, 0.000000001, (2**(0.size * 8 -2) -1)]
  POSITIVE_INTEGERS = [1, 2, 3, 4, 5, 6, 7]
  ZERO = 0
  SEVENTY_THOUSAND = 70000
  ONE_THOUSAND = 1000
  MINUS_THOUSAND = -1000
  FIFTY = 50
  NEGATIVE_NUMBERS = [-1, -10, -1.1, -0.00000001]

  INVALID_EMAILS = [nil, '', '@abc.com']
  INVALID_IDS = [-1, 0, '', nil, 'hue']
  INVALID_CPFS = ['61', '', nil, '522..372.648-55', '000522.372.648-05', 11111111111]
  INVALID_DATES = ['Not a date', '///', '/', '20', '19//01/1222', '18/04/1994', '1994/04/18', '1994-4-18', '2018-02-29']
  INVALID_NUMBERS = ['not a number!', ',3', '.3', '1.', '.']
  INVALID_INTEGERS = INVALID_NUMBERS + %w(1,3 1.7)
  INVALID_FILES = ['C:\a\file\is\not\a\filepath']
  INVALID_STRINGS = [1, {}, [], 1..2, Time.now]
  INVALID_ENUM_VALUES = ['this should never be a valid enum value']
  INVALID_BOOLEANS = ['', nil, -1]
  INVALID_HASHES = ['', nil, -1]
  INVALID_CNPJS = ['61', '', nil, '66.873.046/', 0, '88.359.811/6661-24']


  # Parsers
  TWO_LINES = 'two_lines.csv'

  JWT_PAYLOAD = {key_1: 1, key_2: 'test'}

  INCONSISTENT_PAGE_VALUES = [
      'huehue',
      '       ',
      ' ',
      '',
      '1,5',
      '1dakjshdkasjdhkjashd'
  ]

  OUT_OF_RANGE_PAGE_VALUES = [
      -(2**(0.size * 8 -2)),
      -1,
      99999999,
      999999999,
      9999999999,
      99999999999,
      999999999999,
      9999999999999,
      99999999999999,
      999999999999999,
      9999999999999999,
      99999999999999999,
      (2**(0.size * 8 -2) -1)
  ]

end