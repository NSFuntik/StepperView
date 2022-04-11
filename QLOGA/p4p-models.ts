/* tslint:disable */
/* eslint-disable */
// Generated using typescript-generator version 2.32.889 on 2022-03-11 15:57:23.

export interface AssignFieldsSelector extends FieldsSelector {
    self: AssignFields[];
    resource: HresFields[];
    order: OrderFields[];
}

export interface Contacts {
}

export interface FieldsSelector {
}

export interface HresFieldsSelector extends FieldsSelector {
    self: HresFields[];
    person: any[];
    assigns: AssignFields[];
    prv: PrvFields[];
    prvVrfs: any[];
    prvOrg: any[];
}

export interface LifeCycled {
    history: StatusRecord[];
    statusRecord: StatusRecord;
}

export interface OrderFieldsSelector extends FieldsSelector {
    self: OrderFields[];
    assigns: AssignFields[];
    cst: CstFields[];
    cstReview: OrderReviewFields[];
    cstPerson: any[];
    cstVrfs: any[];
    prv: PrvFields[];
    prvReview: OrderReviewFields[];
    prvVrfs: any[];
    prvOrg: any[];
    services: OrderServicesFields[];
}

export interface Rating {
    rating: number;
    feedbackCategoryId: number;
    categoryName: string;
}

export interface RqFieldsSelector extends FieldsSelector {
    self: RqFields[];
    addr: any[];
    cstReview: OrderReviewFields[];
    cstVrfs: any[];
    services: RqServicesFields[];
}

export interface CstPublicProfile {
    id: number;
    avatarId: number;
    fname: string;
    mname: string;
    sname: string;
    email: string;
    phoneCountry: string;
    phoneNumber: number;
    address: Address;
    contacts: Contacts;
    active: boolean;
    enrollDate: Date;
    rating: number;
    orderQuantity: number;
    ratings: Rating[];
    vrfs: Verification[];
}

export interface Customer {
    id: number;
    personId: number;
    active: boolean;
    marketingAllowed: boolean;
    enrollDate: Date;
    favs: Provider[];
    rating: number;
    qty: number;
    total: number;
    ratingsByCat: Rating[];
}

export interface EPDQResponse {
    orderID: string;
    PAYID: string;
    QPID: string;
    amount: number;
    currency: string;
    ip: string;
    aavcheck: string;
    cvccheck: string;
    acceptance: string;
    ncerrorplus: string;
    ncstatus: number;
    payidsub: number;
    orderId: number;
    payid: number;
    qpid: number;
    ncerror: number;
    trxdate: Date;
    status: number;
    cn: string;
    ipcty: string;
    cccty: string;
    eci: number;
    vc: string;
    pm: string;
    brand: string;
    cardno: string;
    alias: string;
    ed: Date;
    last4: number;
}

export interface PrvSearchResult {
    prv: Provider;
    distance: number;
}

export interface ApplicantPublicProfile {
    id: number;
    fname: string;
    mname: string;
    sname: string;
    phone: string;
    email: string;
    address: Address;
    verifications: Verification[];
    gender: any;
    active: boolean;
    blocked: boolean;
    langs: string[];
    avatarId: number;
    regDate: Date;
}

export interface Assign extends LifeCycled {
    id: number;
    order: Order;
    resource: Hres;
    senior: boolean;
    from: Date;
    to: Date;
    meetup: MeetUp;
    hresActions: AssignHresAction[];
    prvActions: AssignPrvAction[];
}

export interface Hres {
    id: number;
    personId: number;
    providerId: number;
    jobAppId: number;
    status: ResourceStatus;
    reason: Reason4Leaving;
    leavingDetails: string;
    endContract: Date;
    consentDate: Date;
    rate: number;
    rateDate: Date;
    soloProvider: boolean;
    person: Person;
    prv: Provider;
    prvOrg: Org;
    prvVrfs: Verification[];
    workHours: WorkHours[];
    offTime: OffTime[];
    assignments: Assign[];
}

export interface HresPublicProfile {
    fname: string;
    mname: string;
    sname: string;
    phone: string;
    email: string;
    address: Address;
    verifications: Verification[];
    gender: any;
    active: boolean;
    blocked: boolean;
    langs: string[];
    avatarId: number;
    regDate: Date;
    workHours: WorkHours[];
    offTime: OffTime[];
}

export interface JobApp extends LifeCycled {
    id: number;
    appliedDate: Date;
    coverNote: string;
    reason: Reason4Leaving;
    leavingDetails: string;
    job: Job;
    applicant: ApplicantPublicProfile;
    workHours: WorkHours[];
    offTime: OffTime[];
    prvActions: JobAppPrvAction[];
    hresActions: JobAppApplicantAction[];
}

export interface FeedbackCat extends CachedDTO {
    sortOrder: number;
    name: string;
    descr: string;
    feedbackType: boolean;
}

export interface QService extends CachedDTO {
    sortOrder: number;
    name: string;
    descr: string;
    unit: string;
    unitDescr: string;
    subject: string;
    works: string;
    exclusions: string;
    timeNorm: number;
    timeNormMandated: boolean;
    avatarId: number;
    avatarUrl: string;
}

export interface ServiceCategory extends CachedDTO {
    sortOrder: number;
    name: string;
    descr: string;
    avatarUrl: string;
    mapUrl: string;
    adminVrfs: any[];
    orgVrfs: any[];
    clearances: number[];
    services: QService[];
}

export interface ServiceCondition extends CachedDTO {
    sortOrder: number;
    name: string;
    descr: string;
    serviceCatId: number;
}

export interface ServiceUnit extends CachedDTO {
    sortOrder: number;
    code: string;
    descr: string;
    timed: boolean;
    minutes: number;
}

export interface MeetUp {
    time: Date;
    lat: number;
    lng: number;
}

export interface Order extends LifeCycled {
    id: number;
    addr: Address;
    album: MediaAlbum;
    amount: number;
    calloutAmount: number;
    callout: boolean;
    serviceDate: Date;
    request: Rq;
    services: OrderedService[];
    provider: Provider;
    providerOrg: Org;
    cancelHrs: number;
    providerPart: OrderPart;
    customerPart: OrderPart;
    customer: Customer;
    cstPerson: Person;
    dayPlans: OrderDayPlan[];
    meetup: MeetUp;
    cstActions: CstActionEnum[];
    prvActions: PrvActionEnum[];
    payments: PayTxn[];
    assigns: Assign[];
}

export interface OrderActionResult {
    order: Order;
    result: any;
    warning: string;
}

export interface OrderDayPlan extends IDayPlan {
    visit1: Visit;
    visit2: Visit;
    visit3: Visit;
}

export interface OrderNtfSummary {
    id: number;
    addr: Address;
    cstId: number;
    cstName: string;
    prvId: number;
    prvName: string;
    serviceDate: Date;
    sum: number;
    status: StatusRecord;
}

export interface OrderPart {
    notes: string;
    review: OrderReview;
}

export interface OrderReview {
    cstDate: Date;
    prvDate: Date;
    privateFeedback: string;
    feedback: string;
    moderationPassed: boolean;
    reviewerId: number;
    orderStatus: OrderStatus;
    cstProfile: CstPublicProfile;
    prvProfile: OrgAdminPublicProfile;
    ratings: Rating[];
}

export interface OrderedService {
    id: number;
    conditions: number[];
    qty: number;
    cost: number;
    timeNorm: number;
    qserviceId: number;
}

export interface Visit {
    time: string;
    status: StatusRecord;
    tracks: StatusRecord[];
    prvActions: PrvActionEnum[];
    cstActions: CstActionEnum[];
}

export interface VisitActionData {
    date: Date;
    visitNum: number;
}

export interface VisitMeetUp extends VisitActionData {
    lat: number;
    lng: number;
}

export interface OrderStateMachine {
}

export interface Job extends LifeCycled {
    id: number;
    title: string;
    descr: string;
    rate: number;
    start: Date;
    end: Date;
    occs: number;
    occupancy: JobOccupancy;
    area: string;
    town: string;
    countryCode: string;
    postcode: string;
    radius: number;
    provider: Provider;
    services: number[];
    actions: JobAction[];
    hired: Hres[];
}

export interface Provider {
    id: number;
    active: boolean;
    org: Org;
    contacts: Contacts;
    adminHres: Hres;
    calloutCharge: boolean;
    cancelHrs: number;
    enrollDate: Date;
    services: ProviderService[];
    resourceIds: number[];
    coverageZone: number;
    rating: number;
    qty: number;
    total: number;
    favs: Customer[];
    ratings: Rating[];
    portfolio: MediaAlbum[];
    cancellations: number;
    earned: number;
}

export interface ProviderService extends CachedDTO {
    catcher: boolean;
    conditions: number[];
    unitCost: number;
    unitTimed: boolean;
    timeNorm: number;
    qserviceId: number;
}

export interface ProviderServiceCondition {
    id: number;
    serviceConditionId: number;
    providerServiceId: number;
}

export interface RqSearchResult {
    request: Rq;
    distance: number;
}

export interface Rq extends LifeCycled {
    id: number;
    views: number;
    searches: number;
    offeredSum: number;
    placedDate: Date;
    orderedDate: Date;
    validDate: Date;
    notes: string;
    cstProfile: CstPublicProfile;
    visits: number;
    address: Address;
    services: RqService[];
    cstActions: RqAction[];
}

export interface RqActionResult {
    request: Rq;
    result: any;
    warning: string;
}

export interface RqNtfSummary {
    id: number;
    addr: Address;
    cstId: number;
    cstName: string;
    offeredSum: number;
    notes: string;
    orderedDate: Date;
    validDate: Date;
}

export interface RqService {
    id: number;
    qty: number;
    qserviceId: number;
}

export interface RqServiceCondition {
    id: number;
    serviceConditionId: number;
    requestedServiceId: number;
}

export interface AssignSearchFilter extends SearchFilter {
    status: AssignmentStatus;
    orderId: number;
    hresId: number;
    fromDate: Date;
    toDate: Date;
    exactlyDate: Date;
}

export interface CstRequestSearchFilter extends SearchFilter {
    statuses: RqStatus[];
    ageHrs: number;
}

export interface HresSearchFilter extends SearchFilter {
    providerId: number;
    status: ResourceStatus;
}

export interface JobSearchFilter extends SearchFilter {
    proximity: number;
    serviceCatIds: number[];
    serviceIds: number[];
    providerId: number;
}

export interface OrderFilter extends SearchFilter {
    openClosed: boolean;
    statuses: OrderStatus[];
    tab: OrderViewTab;
    orderId: number;
    providerId: number;
    customerId: number;
    fromDate: Date;
    toDate: Date;
    exactlyDate: Date;
    exactlySum: number;
    fromSum: number;
    toSum: number;
}

export interface PrvRequestSearchFilter extends SearchFilter {
    proximity: number;
    rating: number;
    vrfTypes: any[];
    matchServices: boolean;
    minOfferSum: number;
    mapCentreLat: number;
    mapCentreLng: number;
}

export interface PrvSearchFilter extends SearchFilter {
    proximity: number;
    rating: number;
    vrfTypes: any[];
    serviceIds: number[];
    serviceCatIds: number[];
    clearanceTypeId: number;
    individual: boolean;
    ordersQty: number;
    repeatedCustomerRate: number;
    mapCentreLat: number;
    mapCentreLng: number;
}

export interface SearchFilter {
    tz: TimeZone;
}

export interface StatusRecord {
    date: Date;
    actor: ActorsEnum;
    actorId: number;
    action: string;
    note: string;
    status: string;
    display: string;
    actionDisplay: string;
    actionPast: string;
}

export interface Address extends CachedDTO, ILatLng {
    familyId: number;
    country: string;
    line1: string;
    line2: string;
    line3: string;
    line4: string;
    town: string;
    postcode: string;
    parking: Parking;
    zoneId: string;
    timeOffset: number;
    vrfs: Verification[];
    businessOnly: boolean;
}

export interface Verification extends CachedDTO {
    type: any;
    holderType: any;
    subjId: number;
    holderId: number;
    date: Date;
    expires: Date;
    notes: string;
}

export interface Person extends CachedDTO {
    familyId: number;
    fname: string;
    mname: string;
    madenname: string;
    sname: string;
    cognitoId: string;
    email: string;
    phoneCountry: string;
    phoneNumber: number;
    gender: any;
    dob: Date;
    created: Date;
    phoneVerified: boolean;
    avatarVerified: boolean;
    avatarId: number;
    verifications: Verification[];
    settings: { [index: string]: string };
    langs: string[];
    address: Address;
    oktaStatus: string;
    oktaStatusUpdated: Date;
    payMethods: PayMethod[];
    cal: Cal;
}

export interface Org extends CachedDTO {
    name: string;
    descr: string;
    adminId: number;
    avatarId: number;
    active: boolean;
    individual: boolean;
    email: string;
    website: string;
    nonForProfit: boolean;
    phoneCountry: string;
    phoneNumber: number;
    regDetails: string;
    insurance: string;
    admin: OrgAdminPublicProfile;
    addr: Address;
    offTime: OffTime[];
    workingHours: WorkHours[];
    verifications: Verification[];
    langs: string[];
    settings: { [index: string]: string };
    cal: Cal;
}

export interface WorkHours extends CachedDTO {
    weekDay: DayOfWeek;
    from: string;
    to: string;
}

export interface OffTime extends CachedDTO {
    from: Date;
    to: Date;
}

export interface CachedDTO {
    id: number;
}

export interface MediaAlbum extends CachedDTO {
    name: string;
    descr: string;
    updatedDate: Date;
    medias: MediaMeta[];
    ownerId: number;
    ownerFamilyId: number;
    avatarId: number;
    access: any;
}

export interface PayTxn extends CachedDTO {
    payerId: number;
    date: Date;
    refId: number;
    refType: PayTxnRefType;
    payId: number;
    paySubId: number;
    errCode: number;
    errText: string;
    status: number;
    statusText: string;
    cardholder: string;
    brand: string;
    expiryDate: Date;
    last4: number;
    amount: number;
}

export interface IDayPlan {
    id: number;
    day: Date;
}

export interface OrgAdminPublicProfile extends CachedDTO {
    fname: string;
    mname: string;
    madenname: string;
    sname: string;
    avatarId: number;
    address: Address;
    email: string;
    vrfs: Verification[];
    phone: string;
}

export interface TimeZone extends Cloneable {
}

export interface ILatLng {
    lat: number;
    lng: number;
}

export interface PayMethod extends CachedDTO {
    payId: number;
    cardholderName: string;
    brand: string;
    expiryDate: Date;
    last4: number;
    active: boolean;
    defaultMethod: boolean;
}

export interface Cal extends CachedDTO {
    name: string;
    type: CalType;
    refId: number;
}

export interface MediaMeta extends CachedDTO {
    filename: string;
    summary: string;
    contentType: string;
    width: number;
    height: number;
    size: number;
    uploadedDate: Date;
    access: any;
    uploaderId: number;
    vrfs: Verification[];
}

export interface Cloneable {
}

export enum ActorsEnum {
    QLOGA = "QLOGA",
    CUSTOMER = "CUSTOMER",
    PROVIDER = "PROVIDER",
    RESOURCE = "RESOURCE",
    JOB_APPLICANT = "JOB_APPLICANT",
}

export enum CstFields {
    ID = "ID",
    PERSON_ID = "PERSON_ID",
    ACTIVE = "ACTIVE",
    MARKETING_ALLOWED = "MARKETING_ALLOWED",
    ENROLL_DATE = "ENROLL_DATE",
    RATING = "RATING",
    QTY = "QTY",
    TOTAL = "TOTAL",
    RATINGS = "RATINGS",
    PUBLIC_PROFILE = "PUBLIC_PROFILE",
    FAVS = "FAVS",
    PARKING = "PARKING",
}

export enum CstPublicProfileFields {
    ID = "ID",
    NAME = "NAME",
    ADDRESS = "ADDRESS",
    AVATAR = "AVATAR",
    EMAIL = "EMAIL",
    VRFS = "VRFS",
    PHONE = "PHONE",
    ACTIVE = "ACTIVE",
    ENROLL_DATE = "ENROLL_DATE",
    RATING = "RATING",
    ORDERS_QTY = "ORDERS_QTY",
}

export enum CstPublicProfileKey {
    P4P_CST_PPROFILE_FNAME = "P4P_CST_PPROFILE_FNAME",
    P4P_CST_PPROFILE_MNAME = "P4P_CST_PPROFILE_MNAME",
    P4P_CST_PPROFILE_SNAME = "P4P_CST_PPROFILE_SNAME",
    P4P_CST_PPROFILE_LINE1 = "P4P_CST_PPROFILE_LINE1",
    P4P_CST_PPROFILE_LINE2 = "P4P_CST_PPROFILE_LINE2",
    P4P_CST_PPROFILE_LINE3 = "P4P_CST_PPROFILE_LINE3",
    P4P_CST_PPROFILE_LINE4 = "P4P_CST_PPROFILE_LINE4",
    P4P_CST_PPROFILE_TOWN = "P4P_CST_PPROFILE_TOWN",
    P4P_CST_PPROFILE_POSTCODE = "P4P_CST_PPROFILE_POSTCODE",
    P4P_CST_PPROFILE_COUNTRY = "P4P_CST_PPROFILE_COUNTRY",
    P4P_CST_PPROFILE_PHONE = "P4P_CST_PPROFILE_PHONE",
    P4P_CST_PPROFILE_EMAIL = "P4P_CST_PPROFILE_EMAIL",
    P4P_CST_PPROFILE_AVATAR = "P4P_CST_PPROFILE_AVATAR",
    P4P_CST_PPROFILE_RATING = "P4P_CST_PPROFILE_RATING",
    P4P_CST_PPROFILE_QTY = "P4P_CST_PPROFILE_QTY",
    P4P_CST_PPROFILE_ENROLLDATE = "P4P_CST_PPROFILE_ENROLLDATE",
    P4P_CST_PPROFILE_ACTIVE = "P4P_CST_PPROFILE_ACTIVE",
}

export enum ApplicantPublicProfileKey {
    P4P_APPL_PPROFILE_FNAME = "P4P_APPL_PPROFILE_FNAME",
    P4P_APPL_PPROFILE_MNAME = "P4P_APPL_PPROFILE_MNAME",
    P4P_APPL_PPROFILE_SNAME = "P4P_APPL_PPROFILE_SNAME",
    P4P_APPL_PPROFILE_LINE1 = "P4P_APPL_PPROFILE_LINE1",
    P4P_APPL_PPROFILE_LINE2 = "P4P_APPL_PPROFILE_LINE2",
    P4P_APPL_PPROFILE_LINE3 = "P4P_APPL_PPROFILE_LINE3",
    P4P_APPL_PPROFILE_LINE4 = "P4P_APPL_PPROFILE_LINE4",
    P4P_APPL_PPROFILE_TOWN = "P4P_APPL_PPROFILE_TOWN",
    P4P_APPL_PPROFILE_POSTCODE = "P4P_APPL_PPROFILE_POSTCODE",
    P4P_APPL_PPROFILE_COUNTRY = "P4P_APPL_PPROFILE_COUNTRY",
    P4P_APPL_PPROFILE_PHONE = "P4P_APPL_PPROFILE_PHONE",
    P4P_APPL_PPROFILE_EMAIL = "P4P_APPL_PPROFILE_EMAIL",
    P4P_APPL_PPROFILE_VERIFICATIONS = "P4P_APPL_PPROFILE_VERIFICATIONS",
    P4P_APPL_PPROFILE_GENDER = "P4P_APPL_PPROFILE_GENDER",
    P4P_APPL_PPROFILE_ACTIVE = "P4P_APPL_PPROFILE_ACTIVE",
    P4P_APPL_PPROFILE_BLOCKED = "P4P_APPL_PPROFILE_BLOCKED",
    P4P_APPL_PPROFILE_LANGS = "P4P_APPL_PPROFILE_LANGS",
    P4P_APPL_PPROFILE_AVATAR = "P4P_APPL_PPROFILE_AVATAR",
    P4P_APPL_PPROFILE_REG_DATE = "P4P_APPL_PPROFILE_REG_DATE",
}

export enum AssignHresAction {
    ARRIVED_ONSITE = "ARRIVED_ONSITE",
    MARK_NOBODY_HOME = "MARK_NOBODY_HOME",
    COMPLETE = "COMPLETE",
    CANCEL = "CANCEL",
}

export enum HresFields {
    ID = "ID",
    STATUS = "STATUS",
    REASON = "REASON",
    LEAVING_DETAILS = "LEAVING_DETAILS",
    END_CONTRACT = "END_CONTRACT",
    CONSENT_DATE = "CONSENT_DATE",
    RATE = "RATE",
    RATE_DATE = "RATE_DATE",
    SOLO = "SOLO",
    OFF_TIME = "OFF_TIME",
    WORK_HOURS = "WORK_HOURS",
}

export enum HresPublicProfileKey {
    P4P_HRES_PPROFILE_FNAME = "P4P_HRES_PPROFILE_FNAME",
    P4P_HRES_PPROFILE_MNAME = "P4P_HRES_PPROFILE_MNAME",
    P4P_HRES_PPROFILE_SNAME = "P4P_HRES_PPROFILE_SNAME",
    P4P_HRES_PPROFILE_LINE1 = "P4P_HRES_PPROFILE_LINE1",
    P4P_HRES_PPROFILE_LINE2 = "P4P_HRES_PPROFILE_LINE2",
    P4P_HRES_PPROFILE_LINE3 = "P4P_HRES_PPROFILE_LINE3",
    P4P_HRES_PPROFILE_LINE4 = "P4P_HRES_PPROFILE_LINE4",
    P4P_HRES_PPROFILE_TOWN = "P4P_HRES_PPROFILE_TOWN",
    P4P_HRES_PPROFILE_POSTCODE = "P4P_HRES_PPROFILE_POSTCODE",
    P4P_HRES_PPROFILE_COUNTRY = "P4P_HRES_PPROFILE_COUNTRY",
    P4P_HRES_PPROFILE_PHONE = "P4P_HRES_PPROFILE_PHONE",
    P4P_HRES_PPROFILE_EMAIL = "P4P_HRES_PPROFILE_EMAIL",
    P4P_HRES_PPROFILE_VERIFICATIONS = "P4P_HRES_PPROFILE_VERIFICATIONS",
    P4P_HRES_PPROFILE_GENDER = "P4P_HRES_PPROFILE_GENDER",
    P4P_HRES_PPROFILE_ACTIVE = "P4P_HRES_PPROFILE_ACTIVE",
    P4P_HRES_PPROFILE_BLOCKED = "P4P_HRES_PPROFILE_BLOCKED",
    P4P_HRES_PPROFILE_LANGS = "P4P_HRES_PPROFILE_LANGS",
    P4P_HRES_PPROFILE_AVATAR = "P4P_HRES_PPROFILE_AVATAR",
    P4P_HRES_PPROFILE_REG_DATE = "P4P_HRES_PPROFILE_REG_DATE",
    P4P_HRES_PPROFILE_WORK_HOURS = "P4P_HRES_PPROFILE_WORK_HOURS",
    P4P_HRES_PPROFILE_OFF_TIME = "P4P_HRES_PPROFILE_OFF_TIME",
}

export enum JobAppApplicantAction {
    APPLY = "APPLY",
    ACCEPT_OFFER = "ACCEPT_OFFER",
    DELETE = "DELETE",
    WITHDRAW = "WITHDRAW",
    RESIGN = "RESIGN",
}

export enum JobAppPrvAction {
    OFFER_JOB = "OFFER_JOB",
    SELECT = "SELECT",
    DECLINE = "DECLINE",
}

export enum JobAppStatus {
    APPLIED = "APPLIED",
    DECLINED = "DECLINED",
    SELECTED = "SELECTED",
    JOB_OFFERED = "JOB_OFFERED",
    OFFER_ACCEPTED = "OFFER_ACCEPTED",
    WITHDRAWN = "WITHDRAWN",
    RESIGNED = "RESIGNED",
}

export enum CstActionEnum {
    PROPOSE = "PROPOSE",
    DELETE = "DELETE",
    UPDATE = "UPDATE",
    DECLINE = "DECLINE",
    AUTO_DECLINE = "AUTO_DECLINE",
    ACCEPT = "ACCEPT",
    ARRIVED = "ARRIVED",
    APPROVE = "APPROVE",
    VISIT_ARRIVED = "VISIT_ARRIVED",
    VISIT_NOT_ARRIVED = "VISIT_NOT_ARRIVED",
    VISIT_APPROVE = "VISIT_APPROVE",
    VISIT_CANCEL = "VISIT_CANCEL",
    VISIT_UNSATISFIED = "VISIT_UNSATISFIED",
    PROVIDE_FUNDS = "PROVIDE_FUNDS",
    REVIEW = "REVIEW",
    NO_REVIEW = "NO_REVIEW",
    RESCHEDULE = "RESCHEDULE",
    CANCEL_EARLY = "CANCEL_EARLY",
    CANCEL = "CANCEL",
    DISPUTE = "DISPUTE",
    NOT_ARRIVED = "NOT_ARRIVED",
    CST_UNSATISFIED = "CST_UNSATISFIED",
}

export enum OrderFields {
    ID = "ID",
    REQUEST = "REQUEST",
    ADDR = "ADDR",
    ALBUM = "ALBUM",
    SERVICE_DATE = "SERVICE_DATE",
    SUM = "SUM",
    CANCELLATION_HRS = "CANCELLATION_HRS",
    CALLOUT = "CALLOUT",
    PAYMENTS = "PAYMENTS",
    MEETUP = "MEETUP",
    SERVICES = "SERVICES",
    RESOURCES = "RESOURCES",
    RPT = "RPT",
    CST_ID = "CST_ID",
    CST_FNAME = "CST_FNAME",
    CST_SNAME = "CST_SNAME",
    CST_PHONE = "CST_PHONE",
    CST_NOTES = "CST_NOTES",
    CST_ACTIONS = "CST_ACTIONS",
    PRV_NOTES = "PRV_NOTES",
    PRV_ACTIONS = "PRV_ACTIONS",
    STATUS = "STATUS",
    HISTORY = "HISTORY",
}

export enum OrderPayGuards {
    CAPTURE = "CAPTURE",
    DELETE_AUTH = "DELETE_AUTH",
}

export enum OrderPhase {
    Negotiation = "Negotiation",
    Execution = "Execution",
    Feedback = "Feedback",
    Dispute = "Dispute",
}

export enum OrderReviewFields {
    DATE = "DATE",
    PRIVATE_FEEDBACK = "PRIVATE_FEEDBACK",
    PUBLIC_FEEDBACK = "PUBLIC_FEEDBACK",
    REVIEWER_ID = "REVIEWER_ID",
    ORDER_STATUS = "ORDER_STATUS",
    RATING = "RATING",
}

export enum OrderServicesFields {
    ID = "ID",
    SERVICES = "SERVICES",
    SERVICE_QID = "SERVICE_QID",
    SERVICE_NAME = "SERVICE_NAME",
    SERVICE_UNIT_CODE = "SERVICE_UNIT_CODE",
    SERVICE_QTY = "SERVICE_QTY",
}

export enum OrderStatus {
    QUOTE = "QUOTE",
    INQUIRY = "INQUIRY",
    NEEDS_FUNDING = "NEEDS_FUNDING",
    AUTH_DEL_IN_PROGRESS = "AUTH_DEL_IN_PROGRESS",
    AUTH_IN_PROGRESS = "AUTH_IN_PROGRESS",
    CST_DECLINED = "CST_DECLINED",
    PRV_DECLINED = "PRV_DECLINED",
    ACCEPTED = "ACCEPTED",
    ARRIVED = "ARRIVED",
    PRV_NEAR = "PRV_NEAR",
    COMPLETED = "COMPLETED",
    VISIT_PRV_NEAR = "VISIT_PRV_NEAR",
    VISIT_ARRIVED = "VISIT_ARRIVED",
    VISIT_COMPLETED = "VISIT_COMPLETED",
    VISIT_CANCELLED = "VISIT_CANCELLED",
    VISIT_UNSATISFIED = "VISIT_UNSATISFIED",
    VISIT_PAYMENT_IN_PROGRESS = "VISIT_PAYMENT_IN_PROGRESS",
    VISIT_PAID = "VISIT_PAID",
    VISIT_APPROVED = "VISIT_APPROVED",
    VISIT_CALLOUT_2PAY = "VISIT_CALLOUT_2PAY",
    PAYMENT_IN_PROGRESS = "PAYMENT_IN_PROGRESS",
    PAYMENT_REFUSED = "PAYMENT_REFUSED",
    VISIT_PAYMENT_REFUSED = "VISIT_PAYMENT_REFUSED",
    APPROVED = "APPROVED",
    PAID = "PAID",
    PRV_REVIEWED = "PRV_REVIEWED",
    CST_REVIEWED = "CST_REVIEWED",
    CLOSED = "CLOSED",
    CANCELLED = "CANCELLED",
    CST_CANCELLED = "CST_CANCELLED",
    UNSATISFIED = "UNSATISFIED",
    IN_DISPUTE = "IN_DISPUTE",
    CALLOUT_2PAY = "CALLOUT_2PAY",
}

export enum OrderViewTab {
    ORDERS = "ORDERS",
    OFFERS = "OFFERS",
    QUOTES = "QUOTES",
    TODAY = "TODAY",
}

export enum PrvActionEnum {
    PROPOSE = "PROPOSE",
    DELETE = "DELETE",
    DECLINE = "DECLINE",
    AUTO_DECLINE = "AUTO_DECLINE",
    UPDATE = "UPDATE",
    ACCEPT = "ACCEPT",
    MARK_ARRIVAL = "MARK_ARRIVAL",
    ARRIVED_NO_GPS = "ARRIVED_NO_GPS",
    COMPLETE = "COMPLETE",
    VISIT_NOBODY_HOME = "VISIT_NOBODY_HOME",
    VISIT_COMPLETE = "VISIT_COMPLETE",
    VISIT_MARVL_NO_GPS = "VISIT_MARVL_NO_GPS",
    VISIT_CANCEL = "VISIT_CANCEL",
    VISIT_MARVL = "VISIT_MARVL",
    VISIT_RQ_COUT_CHARGE = "VISIT_RQ_COUT_CHARGE",
    REVIEW = "REVIEW",
    NO_REVIEW = "NO_REVIEW",
    RESCHEDULE = "RESCHEDULE",
    RQ_COUT_CHARGE = "RQ_COUT_CHARGE",
    NOBODY_HOME = "NOBODY_HOME",
    DISPUTE = "DISPUTE",
    CANCEL_EARLY = "CANCEL_EARLY",
    CANCEL = "CANCEL",
}

export enum QlogaActionEnum {
    FUNDS_CAPTURE_REQUEST = "FUNDS_CAPTURE_REQUEST",
    FUNDS_CAPTURE_CONFIRMATION = "FUNDS_CAPTURE_CONFIRMATION",
    FUNDS_RESERVATION_DECLINED = "FUNDS_RESERVATION_DECLINED",
    FUNDS_RESERVATION_AUTHORIZED = "FUNDS_RESERVATION_AUTHORIZED",
    AUTO_PRV_NOT_ARRIVED = "AUTO_PRV_NOT_ARRIVED",
    AUTO_QUOTE_DECLINE = "AUTO_QUOTE_DECLINE",
    AUTO_INQUIRY_DECLINE = "AUTO_INQUIRY_DECLINE",
    AUTO_NO_REVIEW = "AUTO_NO_REVIEW",
    AUTO_CANCEL_COMPLETED = "AUTO_CANCEL_COMPLETED",
    AUTO_CANCEL_UNSATISFIED = "AUTO_CANCEL_UNSATISFIED",
    CLOSE_DISPUTE_WINDOW = "CLOSE_DISPUTE_WINDOW",
    AUTH_DELETION_REQUEST = "AUTH_DELETION_REQUEST",
}

export enum AssignFields {
    ID = "ID",
    SENIOR = "SENIOR",
    FROM = "FROM",
    TO = "TO",
    STATUS = "STATUS",
    MEETUP = "MEETUP",
    HISTORY = "HISTORY",
    HRES_ACTIONS = "HRES_ACTIONS",
    PRV_ACTIONS = "PRV_ACTIONS",
}

export enum AssignPrvAction {
    CREATE = "CREATE",
    CONFIRM = "CONFIRM",
    ADMIN_ARRIVED = "ADMIN_ARRIVED",
    ADMIN_COMPLETED = "ADMIN_COMPLETED",
    CANCEL = "CANCEL",
}

export enum AssignmentStatus {
    ASKED = "ASKED",
    CREATED = "CREATED",
    CONFIRMED = "CONFIRMED",
    ONSITE = "ONSITE",
    NOBODY_HOME = "NOBODY_HOME",
    CANCELLED = "CANCELLED",
    COMPLETED = "COMPLETED",
}

export enum JobAction {
    CREATE = "CREATE",
    ACTIVATE = "ACTIVATE",
    DELETE = "DELETE",
    CLOSE = "CLOSE",
}

export enum JobAppFields {
    ID = "ID",
    DATE = "DATE",
    COVER_NOTE = "COVER_NOTE",
    JOB = "JOB",
    APPLICANT = "APPLICANT",
    WORK_HOURS = "WORK_HOURS",
    OFF_TIME = "OFF_TIME",
    HRES_ACTIONS = "HRES_ACTIONS",
    PRV_ACTIONS = "PRV_ACTIONS",
    STATUS = "STATUS",
    HISTORY = "HISTORY",
}

export enum JobFields {
    ID = "ID",
    TITLE = "TITLE",
    DESCR = "DESCR",
    PRV = "PRV",
    SERVICES = "SERVICES",
    RATE = "RATE",
    HIRED = "HIRED",
    START = "START",
    END = "END",
    OCCS = "OCCS",
    OCCUPANCY = "OCCUPANCY",
    RADIUS = "RADIUS",
    ADDR_TOWN = "ADDR_TOWN",
    ADDR_AREA = "ADDR_AREA",
    ADDR_COUNTRY = "ADDR_COUNTRY",
    ADDR_POSTCODE = "ADDR_POSTCODE",
    ACTIONS = "ACTIONS",
    STATUS = "STATUS",
    HISTORY = "HISTORY",
}

export enum JobOccupancy {
    ONEOFF = "ONEOFF",
    YEARLY = "YEARLY",
    MONTHLY = "MONTHLY",
    DAILY = "DAILY",
    IRREGULAR = "IRREGULAR",
}

export enum JobStatus {
    OPEN = "OPEN",
    HIRING = "HIRING",
    CLOSED = "CLOSED",
}

export enum ProviderPublicProfileKey {
    P4P_PRV_PPROFILE_PHONE = "P4P_PRV_PPROFILE_PHONE",
    P4P_PRV_PPROFILE_OFFTIME = "P4P_PRV_PPROFILE_OFFTIME",
}

export enum PrvFields {
    ID = "ID",
    ACTIVE = "ACTIVE",
    ORG = "ORG",
    CALLOUT = "CALLOUT",
    CANCEL_HRS = "CANCEL_HRS",
    ENROLLED = "ENROLLED",
    SERVICES = "SERVICES",
    RESOURCES = "RESOURCES",
    COVERAGE = "COVERAGE",
    ADMIN_HRES = "ADMIN_HRES",
    RATING = "RATING",
    QTY = "QTY",
    TOTAL = "TOTAL",
    FAVS = "FAVS",
    PORTFOLIO = "PORTFOLIO",
    CANCELLATIONS = "CANCELLATIONS",
    EARNED = "EARNED",
}

export enum PrvServiceFields {
    ID = "ID",
    QID = "QID",
    CATCHER = "CATCHER",
    CONDS = "CONDS",
    COST = "COST",
    TIME_NORM = "TIME_NORM",
}

export enum Reason4Leaving {
    END_OF_CONTRACT = "END_OF_CONTRACT",
    FIRED = "FIRED",
    QUIT = "QUIT",
}

export enum ResourceStatus {
    HIRED = "HIRED",
    LEFT = "LEFT",
    OWNER = "OWNER",
}

export enum RqAction {
    CREATE = "CREATE",
    UPDATE = "UPDATE",
    DELETE = "DELETE",
    CANCEL = "CANCEL",
    RESUME = "RESUME",
    PAUSE = "PAUSE",
    STOP = "STOP",
    LINK_ORDER = "LINK_ORDER",
}

export enum RqFields {
    ID = "ID",
    STATUS = "STATUS",
    HISTORY = "HISTORY",
    SERVICES = "SERVICES",
    VISITS = "VISITS",
    ADDR = "ADDR",
    VIEWS = "VIEWS",
    SEARCHES = "SEARCHES",
    SUM = "SUM",
    PLACED = "PLACED",
    ORDERED = "ORDERED",
    VALID_TILL = "VALID_TILL",
    NOTES = "NOTES",
    CST = "CST",
    ACTIONS = "ACTIONS",
}

export enum RqServicesFields {
    ID = "ID",
    SERVICES = "SERVICES",
    SERVICE_QID = "SERVICE_QID",
    SERVICE_NAME = "SERVICE_NAME",
    SERVICE_UNIT_CODE = "SERVICE_UNIT_CODE",
    SERVICE_QTY = "SERVICE_QTY",
}

export enum RqStatus {
    LIVE = "LIVE",
    EXPIRED = "EXPIRED",
    PAUSED = "PAUSED",
    CANCELLED = "CANCELLED",
}

export enum Parking {
    PAID = "PAID",
    FREE = "FREE",
}

export enum DayOfWeek {
    MONDAY = "MONDAY",
    TUESDAY = "TUESDAY",
    WEDNESDAY = "WEDNESDAY",
    THURSDAY = "THURSDAY",
    FRIDAY = "FRIDAY",
    SATURDAY = "SATURDAY",
    SUNDAY = "SUNDAY",
}

export enum PayTxnRefType {
    subscr = "subscr",
    order = "order",
}

export enum CalType {
    PERSONAL = "PERSONAL",
    FAMILY = "FAMILY",
    P4P_CST = "P4P_CST",
    P4P_PRV = "P4P_PRV",
    ORG = "ORG",
    PUBLIC = "PUBLIC",
}
