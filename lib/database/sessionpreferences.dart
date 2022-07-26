import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackerapp/models/financiermodels.dart';
import 'package:trackerapp/models/jobcardmodels.dart';
import 'package:trackerapp/models/technicianmodels.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/utils/config.dart';

class SessionPreferences {
  // final String _userId = 'userId';

  // final String _fullName = 'fullName';
  // final String _userName = 'userName';
  // final String _email = 'email';

  // final String _loggedIn = 'loggedIn';

  // final String _financierId = 'financierId';
  // final String _financierName = 'financierName';
  // final String _financierEmail = 'financierEmail';

  // final String _custId = 'financierEmail';
  // final String _custCode = 'financierEmail';
  // final String _company = 'financierEmail';
  // final String _priceList = 'financierEmail';
  // final String _custBalance = 'financierEmail';
  // final String _custAvailableCredit = 'custAvailableCredit';
  // final String _custCreditLimit = 'custCreditLimit';

  // final String _liveUrl = 'liveUrl';
  // final String _imageSelection = 'imageSelection';
  // final String _companyName = "_companyName";
  final String _jobCardDate = 'jobCardDate';
  final String _jobCardId = 'jobCardId';
  final String _jobCardCustomer = 'jobCardCustomer';
  final String _jobCardFinPhone = 'jobCardFinPhone';
  final String _jobCardCustPhone = 'jobCardCustPhone';
  final String _jobCardVehReg = 'jobCardVehReg';
  final String _jobCardLocation = 'jobCardLocation';
  final String _jobCardDocNo = 'jobCardDocNo';
  final String _jobCardVehModel = 'jobCardVehModel';
  final String _jobCardNoTracker = 'jobCardNoTracker';
  final String _jobCardRemarks = 'jobCardRemarks';
  final String _userId = 'userId';
  final String _hrId = 'hrId';
  final String _fullName = 'fullName';
  final String _userName = 'userName';
  final String _userPriceList = 'userPriceList';
  final String _active = 'active';
  final String _approved = 'approved';
  final String _email = 'email';
  final String _branchName = 'branchname';
  final String _balance = 'balance';
  final String _availableCredit = 'availableCredit';
  final String _creditLimit = 'creditLimit';
  final String _costCenter = 'costcenter';
  final String _isTechnician = 'technician';
  final String _loggedIn = 'loggedIn';
  final String _custId = 'custid';
  final String _id = 'id';
  final String _name = 'company';
  final String _techId = 'empid';
  final String _techName = 'empname';
  final String _financierEmail = 'email';
  final String _mobile = 'mobile';
  final String _userCust = 'userCust';
  final String _custCode = 'custcode';
  final String _company = 'company';
  final String _count = 'count';
  final String _priceList = 'pricelist';
  final String _invDescrip = 'invDescrip';
  final String _invQty = 'invQty';
  final String _invPrice = 'invPrice';
  final String _thermoPrint = 'thermoPrint';
  final String _btdAddress = 'btdAddress';
  final String _btdName = 'btdName';
  final String _custBalance = 'custBalance';
  final String _custAvailableCredit = 'custAvailableCredit';
  final String _custCreditLimit = 'custCreditLimit';
  final String _odInvCode = 'odInvCode';
  final String _odOriginalPrice = 'odOriginalPrice';
  final String _odInvDescrip = 'odInvDescrip';
  final String _odInvQty = 'odInvQty';
  final String _odInvPrice = 'odInvPrice';
  final String _odItemQty = 'odItemQty';
  final String _odInvDiscount = 'odInvDiscount';
  final String _odItemPrice = 'odItemPrice';
  final String _idInvId = 'idInvId';
  final String _idOriginalPrice = 'idOriginalPrice';
  final String _idItemDesc = 'idItemDesc';
  final String _idVat = 'idVat';
  final String _idDiscount = 'idDiscount';
  final String _idQtySold = 'idQtySold';
  final String _idTotal = 'idTotal';
  final String _pdamount = 'pdamount';
  final String _idRprice = 'idRprice';
  final String _idItemQty = 'idItemQty';
  final String _mrdInvid = 'mrdInvid';
  final String _mrdDesc = 'mrdDesc';
  final String _mrdQty = 'mrdQty';
  final String _mrdItemQty = 'mrdItemQty';
  final String _mrdTotal = 'mrdTotal';
  final String _mrdRprice = 'mrdRprice';
  final String _liveUrl = 'liveUrl';
  final String _imageSelection = 'imageSelection';
  final String _paybillno = "paybillno";
  final String _cashacc = "cashacc";
  final String _cashaccid = "cashaccid";
  final String _pinno = "pinno";
  final String _city = "city";
  final String _address = "address";
  final String _changePrice = "changePrice";
  final String _paymentMode = "paymentMode";
  final String _apiCustomer = "_apiCustomer";
  final String _apiNewCustomer = "_apiNewCustomer";
  final String _companyName = "_companyName";
  Future<void> setCompanySettings(CompanySettings settings) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_liveUrl, settings.baseUrl!);
    sharedPreferences.setString(_imageSelection, settings.imageName!);
  }

  Future<void> setLoggedInUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_userId, user.id!);
    sharedPreferences.setInt(_hrId, user.hrid!);
    // sharedPreferences.setInt(_userPriceList, user.pricelist);
    sharedPreferences.setString(_email, user.email!);
    sharedPreferences.setString(_branchName, user.branchname!);
    // sharedPreferences.setDouble(_pdamount, user.pdamount);
    // sharedPreferences.setDouble(_balance, user.balance);
    // sharedPreferences.setDouble(_availableCredit, user.availablecredit);
    // sharedPreferences.setDouble(_creditLimit, user.creditlimit);

    sharedPreferences.setString(_fullName, user.fullname!);
    sharedPreferences.setString(_userName, user.username!);
    // sharedPreferences.setBool(_active, user.active);
    // sharedPreferences.setBool(_approved, user.approved);
    sharedPreferences.setInt(_costCenter, user.costcenter!);
    sharedPreferences.setBool(_isTechnician, user.technician!);
    // sharedPreferences.setString(_custCode, user.custcode);
    // sharedPreferences.setString(_paybillno, user.paybillno);
    // sharedPreferences.setString(_cashacc, user.cashacc);
    // sharedPreferences.setInt(_cashaccid, user.cashaccid);
    // sharedPreferences.setString(_pinno, user.pinno);
    // sharedPreferences.setString(_city, user.city);
    // sharedPreferences.setString(_address, user.address);
    // sharedPreferences.setBool(_changePrice, user.apiallowretailpricechange);
    // sharedPreferences.setBool(_paymentMode, user.apiallowmultiplepaymode);
    // sharedPreferences.setBool(_apiNewCustomer, user.apiallowaddnewcustomer);
    // sharedPreferences.setBool(_apiCustomer, user.apiallowsalestoanycustomer);
    sharedPreferences.setString(_companyName, user.companyname!);
  }

  Future<User> getLoggedInUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return User(
        id: sharedPreferences.getInt(_userId),
        hrid: sharedPreferences.getInt(_hrId),
        // pricelist: sharedPreferences.getInt(_userPriceList),
        fullname: sharedPreferences.getString(_fullName),
        username: sharedPreferences.getString(_userName),
        branchname: sharedPreferences.getString(_branchName),
        // active: sharedPreferences.getBool(_active),
        // pdamount: sharedPreferences.getDouble(_pdamount),
        // approved: sharedPreferences.getBool(_approved),
        email: sharedPreferences.getString(_email),
        technician: sharedPreferences.getBool(_isTechnician),
        // costcenter: sharedPreferences.getInt(_costCenter),
        custid: sharedPreferences.getInt(_userCust),
        costcenter: sharedPreferences.getInt(_costCenter),
        // balance: sharedPreferences.getDouble(_balance),
        // creditlimit: sharedPreferences.getDouble(_creditLimit),
        // availablecredit: sharedPreferences.getDouble(_availableCredit),
        // paybillno: sharedPreferences.getString(_paybillno),
        // custcode: sharedPreferences.getString(_custCode),
        // cashacc: sharedPreferences.getString(_cashacc),
        // cashaccid: sharedPreferences.getInt(_cashaccid),
        // pinno: sharedPreferences.getString(_pinno),
        // city: sharedPreferences.getString(_city),
        // address: sharedPreferences.getString(_address),
        // apiallowmultiplepaymode: sharedPreferences.getBool(_paymentMode),
        // apiallowretailpricechange: sharedPreferences.getBool(_changePrice),
        // apiallowaddnewcustomer: sharedPreferences.getBool(_apiNewCustomer),
        // apiallowsalestoanycustomer: sharedPreferences.getBool(_apiCustomer),
        companyname: sharedPreferences.getString(_companyName));
  }

  Future<CompanySettings> getCompanySettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return CompanySettings(
        baseUrl: sharedPreferences.getString(_liveUrl),
        imageName: sharedPreferences.getString(_imageSelection));
  }

  // Future<void> setLoggedInUser(User user) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt(_userId, user.id!);

  //   sharedPreferences.setString(_fullName, user.fullname!);
  //   sharedPreferences.setString(_userName, user.username!);
  //   sharedPreferences.setString(_email, user.email!);
  //   sharedPreferences.setString(_companyName, user.companyName!);
  // }

  void setSelectedCustomer(Customer customer) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_custId, customer.custid!);
    // sharedPreferences.setString(_custCode, customer.custcode!);
    sharedPreferences.setString(_company, customer.company!);

    // sharedPreferences.setDouble(
    //     _custAvailableCredit, customer.availcreditlimit);
    // sharedPreferences.setDouble(_custCreditLimit, customer.creditlimit);
  }

  void setSelectedJobCard(JobCard jobCard) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setInt(_jobCardId, jobCard.id!);
    sharedPreferences.setString(_jobCardDate, jobCard.date!);
    sharedPreferences.setString(_jobCardCustomer, jobCard.customername!);
    sharedPreferences.setString(_jobCardFinPhone, jobCard.finphone!);
    sharedPreferences.setString(_jobCardCustPhone, jobCard.custphone!);
    sharedPreferences.setString(_jobCardVehReg, jobCard.vehreg!);
    sharedPreferences.setString(_jobCardLocation, jobCard.location!);
    sharedPreferences.setString(_jobCardDocNo, jobCard.docno!);
    sharedPreferences.setString(_jobCardVehModel, jobCard.vehmodel!);
    sharedPreferences.setInt(_jobCardNoTracker, jobCard.notracker!);
    sharedPreferences.setString(_jobCardRemarks, jobCard.remarks!);
  }

  Future<JobCard> getSelectedJobCard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return JobCard(
      id: sharedPreferences.getInt(_jobCardId),
      date: sharedPreferences.getString(_jobCardDate),
      custphone: sharedPreferences.getString(_jobCardCustPhone),
      customername: sharedPreferences.getString(_jobCardCustomer),
      docno: sharedPreferences.getString(_jobCardDocNo),
      finphone: sharedPreferences.getString(_jobCardFinPhone),
      notracker: sharedPreferences.getInt(_jobCardNoTracker),
      remarks: sharedPreferences.getString(_jobCardRemarks),
      vehmodel: sharedPreferences.getString(_jobCardVehModel),
      vehreg: sharedPreferences.getString(_jobCardVehReg),
      location: sharedPreferences.getString(_jobCardLocation),
    );
  }

  void setSelectedFinancier(Financier financier) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_id, financier.id!);
    sharedPreferences.setString(_financierEmail, financier.email!);
    sharedPreferences.setString(_mobile, financier.mobile!);
    sharedPreferences.setString(_name, financier.name!);

    // sharedPreferences.setDouble(
    //     _custAvailableCredit, customer.availcreditlimit);
    // sharedPreferences.setDouble(_custCreditLimit, customer.creditlimit);
  }

  void setSelectedTecnician(Technician technician) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_techId, technician.id!);

    sharedPreferences.setString(_techName, technician.name!);

    // sharedPreferences.setDouble(
    //     _custAvailableCredit, customer.availcreditlimit);
    // sharedPreferences.setDouble(_custCreditLimit, customer.creditlimit);
  }

  Future<Technician> getSelectedTechnician() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Technician(
      id: sharedPreferences.getInt(_techId),
      // custcode: sharedPreferences.getString(_custCode),
      name: sharedPreferences.getString(_techName),

      // pricelist: sharedPreferences.getInt(_priceList),
      // balance: sharedPreferences.getDouble(_custBalance),
      // availcreditlimit: sharedPreferences.getDouble(_custAvailableCredit),
      // creditlimit: sharedPreferences.getDouble(_custCreditLimit)
    );
  }

  Future<Customer> getSelectedCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Customer(
      custid: sharedPreferences.getInt(_custId),
      // custcode: sharedPreferences.getString(_custCode),
      company: sharedPreferences.getString(_company),

      // pricelist: sharedPreferences.getInt(_priceList),
      // balance: sharedPreferences.getDouble(_custBalance),
      // availcreditlimit: sharedPreferences.getDouble(_custAvailableCredit),
      // creditlimit: sharedPreferences.getDouble(_custCreditLimit)
    );
  }

  Future<Financier> getSelectedFinancier() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Financier(
      id: sharedPreferences.getInt(_id),
      // custcode: sharedPreferences.getString(_custCode),
      name: sharedPreferences.getString(_name),
      // pricelist: sharedPreferences.getInt(_priceList),
      // balance: sharedPreferences.getDouble(_custBalance),
      // availcreditlimit: sharedPreferences.getDouble(_custAvailableCredit),
      // creditlimit: sharedPreferences.getDouble(_custCreditLimit)
    );
  }

  // Future<User> getLoggedInUser() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return User(
  //       id: sharedPreferences.getInt(_userId),
  //       fullname: sharedPreferences.getString(_fullName),
  //       username: sharedPreferences.getString(_userName),
  //       email: sharedPreferences.getString(_email),
  //       companyName: sharedPreferences.getString(_companyName));
  // }

  void setLoggedInStatus(bool loggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_loggedIn, loggedIn);
  }

  Future<bool?> getLoggedInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_loggedIn);
  }
}
