import 'package:crm/common/ext/string_ext.dart';

import '../../data/models/customerpagingdata/customer_paging_data_parameter.dart';
import '../../data/models/short_lost.dart';
import '../../data/models/short_quotation_product.dart';
import '../helper/date_helper.dart';

class GraphQLQueryConstants {
  String mutationCheckDeviceApproval({
    required String imeiCode,
    required String userId,
    required String deviceName,
    required String deviceModel,
    required String deviceId,
    required bool filterOnlyApproved
  }) => '''
    mutation Method {
      methodCrmDeviceRegistration: CrmDeviceRegistration(
        method_name: "search_read",
        method_parameters: {
          domain: [
            ["imei_code", "=", "$imeiCode"], 
            ["user_id.id", "=", "$userId"],
            ["device_name", "=", "$deviceName"],
            ["device_model", "=", "$deviceModel"],
            ["device_id", "=", "$deviceId"],
            ${filterOnlyApproved ? "[\"state\", \"=\", \"approved\"]," : ""}
          ],
          fields: ["device_id", "device_name", "state", "create_date"]
        }
      )
    }
  ''';

  String mutationCheckDeviceExist({
    required String imeiCode,
    required String userId,
    required String deviceName,
    required String deviceModel,
    required String deviceId
  }) => '''
    mutation Method {
      methodCrmDeviceRegistration: CrmDeviceRegistration(
        method_name: "search_read",
        method_parameters: {
          domain: [
            ["imei_code", "=", "$imeiCode"], 
            ["user_id.id", "=", "$userId"],
            ["device_name", "=", "$deviceName"],
            ["device_model", "=", "$deviceModel"],
            ["device_id", "=", "$deviceId"],
          ],
          fields: ["device_id", "device_name", "state", "create_date"]
        }
      )
    }
  ''';

  String mutationRegisterNewDevice({
    required String imeiCode,
    required String userId,
    required String deviceName,
    required String deviceModel,
    required String deviceId
  }) => '''
    mutation Create {
      methodCrmDeviceRegistration: CrmDeviceRegistration(
        CrmDeviceRegistrationValues: {
          imei_code: "$imeiCode",
          user_id: "$userId",
          device_name: "$deviceName",
          device_model: "$deviceModel",
          device_id: "$deviceId",
        }
      ) {
        id
        imei_code
        user_id
        device_name
        device_model
        device_id
        state
        create_date
      }
    }
  ''';

  String get queryUserList => '''
    query MyQuery {
      ResUsers {
        id
        name
        login
      }
    }
  ''';

  String queryUserId(String username) => '''
    query MyQuery{
      ResUsers(domain:[["login", "=", "$username"]]){
        id
        name
        login
        company_id{
          id
          name
          currency_id{
            id
            name
            symbol
          }
        }
        image_1920
      }
    }
  ''';

  String queryUserDetail(String userId) => '''
    query MyQuery {
      ResUsers(id: $userId) {
        id
        name
        login
        email
      }
    }
  ''';

  String get queryLostReason => '''
    query MyQuery {
      CrmLostReason {
        id
        name
      }
    }
  ''';

  String mutationLeadPaging(String loggedUserId) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        method_name: "search_read",
        method_parameters: {
          order: "create_date desc",
          domain: [["type","=","lead"],["user_id.id","=",$loggedUserId],["active", "in", [false,true]],"|",["lost_reason_id", "!=", false],["lost_reason_id", "=", false]],
          fields: ["name",,"priority","partner_name","website","email_from","contact_name","function","mobile","type","user_id","stage_id","active","lost_reason_id"]
        },
      )
    }
  ''';

  String get queryLeadCategory => '''
    query MyQuery {
      CrmStage {
        id
        name
      }
    }
  ''';

  String mutationLeadsDetail({
    required String userId,
    required String leadsId
  }) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        method_name: "search_read",
        method_parameters: {
          domain: [["type","=","lead"],["user_id.id","=","$userId"],"|",["active", "=", ""],["active", "=", True],"|",["lost_reason_id", "!=", ""],["lost_reason_id", "!=", True],["id","=",$leadsId]],
          fields: ["name","title","priority","partner_name","website", "email_from", "contact_name","function","mobile","type","user_id","stage_id","active","lost_reason_id","street","street2","city","state_id","zip","country_id"]
        },
      )
    }
  ''';

  String mutationAddLeads({
    required String name,
    required String titleId,
    required String titleName,
    required String priority,
    required String partnerName,
    required String website,
    required String email,
    required String contactName,
    required String function,
    required String mobile,
    required String street,
    required String street2,
    required String city,
    required String stateId,
    required String zip,
    required String countryId
  }) {
    String title = "";
    if (titleId.isNotEmptyString) {
      title = "title: $titleId";
    }
    String state = "";
    if (stateId.isNotEmptyString) {
      state = "state_id: $stateId";
    }
    String country = "";
    if (countryId.isNotEmptyString) {
      country = "country_id: $countryId";
    }
    return '''
      mutation Create {
        createCrmLead: CrmLead(
          CrmLeadValues: {
            name: "$name",
            priority: "$priority",
            partner_name: "$partnerName",
            website: "$website",
            contact_name: "$contactName",
            function: "$function",
            mobile: "$mobile",
            email_from: "$email",
            street: "$street",
            street2: "$street2",
            city: "$city",
            zip: "$zip",
            ${title.isNotEmptyString ? "$title," : ""}
            ${state.isNotEmptyString ? "$state," : ""}
            ${country.isNotEmptyString ? "$country," : ""}
            type: "lead",
          }
        ) {
          name
          partner_name
          website
          contact_name
          function
          mobile
          type
        }
      }
    ''';
  }

  String mutationEditLeads({
    required String id,
    required String titleId,
    required String titleName,
    required String name,
    required String priority,
    required String partnerName,
    required String website,
    required String email,
    required String contactName,
    required String function,
    required String mobile,
    required String street,
    required String street2,
    required String city,
    required String stateId,
    required String zip,
    required String countryId
  }) {
    String title = "";
    if (titleId.isNotEmptyString) {
      title = "title: $titleId";
    }
    String state = "";
    if (stateId.isNotEmptyString) {
      state = "state_id: $stateId";
    }
    String country = "";
    if (countryId.isNotEmptyString) {
      country = "country_id: $countryId";
    }
    return '''
      mutation Update {
        updateCrmLead: CrmLead(
          id: $id,
          CrmLeadValues: {
            name: "$name",
            priority: "$priority",
            partner_name: "$partnerName",
            website: "$website",
            contact_name: "$contactName",
            function: "$function",
            mobile: "$mobile",
            email_from: "$email",
            street: "$street",
            street2: "$street2",
            city: "$city",
            zip: "$zip",
            ${title.isNotEmptyString ? "$title," : ""}
            ${state.isNotEmptyString ? "$state," : ""}
            ${country.isNotEmptyString ? "$country," : ""}
          }
        ) {
          name
          partner_name
          website
          contact_name
          function
          mobile
        }
      }
    ''';
  }

  String mutationConvertToLostLeads({
    required String id,
    String? lostReasonId
  }) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        id: $id, 
        method_name: "action_set_lost",
        method_parameters: {
          ${lostReasonId.isNotEmptyString ? "lost_reason_id: ${lostReasonId.toEmptyStringNonNull}" : ""}
        }
      ) {
        id
      }
    }
  ''';

  String mutationConvertLeadsToPipeline(String id) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        id: $id, 
        method_name: "action_set_pipeline",
        method_parameters: {}
      ) {
        id
      }
    }
  ''';

  String mutationConvertLeadsToPipelineStep1({
    required String leadsId,
    required String customerId
  }) => '''
    mutation Create {
      createCrmLead2opportunityPartner: CrmLead2opportunityPartner(
        CrmLead2opportunityPartnerValues: {
          name: "convert",
          lead_id: $leadsId,
          team_id: 1,
          action: "exist",
          partner_id: $customerId,
        }
      ) {
        id
      }
    }
  ''';

  String mutationConvertLeadsToPipelineStep2({
    required String lastStep1Id,
    required String leadsId,
    required String userId
  }) => '''
    mutation Method {
      methodCrmLead2opportunityPartner: CrmLead2opportunityPartner(
        id: $lastStep1Id, 
        method_name: "_convert_and_allocate",
        method_parameters: {
          leads: $leadsId,
          user_ids: $userId,
        }
      )
    }
  ''';

  String mutationRestoreLeads(String id) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        id: $id, 
        method_name: "toggle_active",
        method_parameters: {}
      ) {
        id
      }
    }
  ''';

  String get queryPipelineCategory => '''
    query MyQuery {
      CrmStage {
        id
        name
      }
    }
  ''';

  String mutationPipelinePaging(String loggedUserId) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        method_name: "search_read",
        method_parameters: {
          order: "create_date desc",
          domain: [
            ["type", "=", "opportunity"],["user_id.id", "=", "$loggedUserId"],"|",["active", "=", ""],["active", "=", True],"|",["lost_reason_id", "!=", ""],["lost_reason_id", "!=", True]
          ],
          fields: ["name","priority","partner_name","website","contact_name","email_from","function","mobile","type","user_id","stage_id","expected_revenue","active","lost_reason_id","street","street2","city","state_id","zip","country_id"]
        }
      )
    }
  ''';

  String mutationPipelineDetail({
    required String userId,
    required String pipelineId
  }) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        method_name: "search_read",
        method_parameters: {
          domain: [["type","=","opportunity"],["user_id.id","=",$userId],"|",["active", "=", ""],["active", "=", True],"|",["lost_reason_id", "!=", ""],["lost_reason_id", "!=", True],["id","=",$pipelineId]],
          fields: ["name","priority","partner_name","website","contact_name","email_from","function","mobile","type","user_id","stage_id","expected_revenue","active","lost_reason_id","street","street2","city","state_id","zip","country_id","probability","date_deadline"]
        }
      )
    }
  ''';

  String mutationAddPipeline({
    required String name,
    required String priority,
    required String partnerName,
    required String website,
    required String contactName,
    required String email,
    required String function,
    required String mobile,
    required String type,
    required String userId,
    required String expectedRevenue,
    DateTime? dateDeadline,
    String? partnerId
  }) {
    String dateDeadlineString = "";
    if (dateDeadline != null) {
      dateDeadlineString = "date_deadline: \"${DateHelper.standardDateFormat3.format(dateDeadline)}\"";
    }
    return '''
      mutation Create {
        createCrmLead: CrmLead(
          CrmLeadValues: {
            name: "$name",
            priority: "$priority",
            partner_name: "$partnerName",
            website: "$website",
            contact_name: "$contactName",
            email_from: "$email",
            function: "$function",
            mobile: "$mobile",
            type: "$type",
            user_id: $userId,
            expected_revenue: $expectedRevenue,
            ${dateDeadlineString.isNotEmptyString ? "$dateDeadlineString," : ""},
            ${partnerId.isNotEmptyString ? "partner_id: $partnerId" : ""}
          }
        )
        {
          name
          priority
          partner_name
          website
          contact_name
          function
          mobile
          type
          user_id
        }
      }
    ''';
  }

  String mutationEditPipeline({
    required String id,
    required String customerId,
    required String name,
    required String priority,
    required String partnerName,
    required String website,
    required String contactName,
    required String email,
    required String function,
    required String mobile,
    required String expectedRevenue,
    DateTime? dateDeadline,
  }) {
    String dateDeadlineString = "";
    if (dateDeadline != null) {
      dateDeadlineString = "date_deadline: \"${DateHelper.standardDateFormat3.format(dateDeadline)}\"";
    }
    return '''
      mutation Update {
        updateCrmLead: CrmLead(
          id: $id,
          CrmLeadValues: {
            name: "$name",
            priority: "$priority",
            partner_name: "$partnerName",
            website: "$website",
            contact_name: "$contactName",
            email_from: "$email",
            function: "$function",
            mobile: "$mobile",  
            expected_revenue: $expectedRevenue,
            ${dateDeadlineString.isNotEmptyString ? "$dateDeadlineString," : ""},
            partner_id: $customerId
          }
        ) {
          name
          priority
          partner_name
          website
          contact_name
          function
          mobile
        }
      }
    ''';
  }

  String mutationConvertToLostPipeline(String id) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        id: $id, 
        method_name: "action_set_lost",
        method_parameters: {}
      ) {
        id
      }
    }
  ''';

  String mutationPipelineNextStage(String id) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        id: $id, 
        method_name: "action_set_next_stage",
        method_parameters: {}
      ) {
        id
      }
    }
  ''';

  String mutationPipelineChangeStage({
    required String pipelineId,
    required String stageId
  }) => '''
    mutation Update {
      updateCrmLead: CrmLead(
        id: $pipelineId,
        CrmLeadValues: {
          stage_id: $stageId
        }
      ) {
        name
        stage_id {
          id
          name
        }
      }
    }
  ''';

  String mutationRestorePipeline(String id) => '''
    mutation Method {
      methodCrmLead: CrmLead(
        id: $id, 
        method_name: "toggle_active",
        method_parameters: {}
      ) {
        id
      }
    }
  ''';

  String mutationHistoryPipelineActivity(String? pipelineId) => '''
    mutation Method { 
      methodMailActivity: MailActivity(
        method_name: "search_read", 
        method_parameters: { 
          order: "create_date desc",
          domain: [["res_model","=","crm.lead"]${pipelineId.isNotEmptyString ? ",[\"res_id\",\"=\", $pipelineId]" : ""}],
          fields: [
            "id",
            "res_name",
            "activity_type_id",
            "summary",
            "date_deadline"
            "res_id",
            "create_date"
          ]
        },
      )
    }
  ''';

  String queryHistoryActivityForPipeline(String userId) => '''
    mutation Method { 
      methodMailActivity: MailActivity( 
        method_name: "search_read", 
        method_parameters: { 
          domain: [["user_id.id","=",$userId], ["res_model","=","crm.lead"]],
          order: "create_date desc",
          fields: [
            "id",
            "res_name",
            "activity_type_id",
            "summary",
            "date_deadline",
            "res_id",
            "calendar_event_id",
            "create_date"
          ]
        }
      )
    }
  ''';

  String queryHistoryActivityForCalendar(String userId) => '''
    query MyQuery{
      CalendarEvent(
        order: "create_date desc",
        domain: [["user_id.id","=",$userId],["res_model", "=", "crm.lead"]]
      ){
        id
        name
        start
        stop
        location
        videocall_location
        res_id
        attendance_id{
          id
          activity_state
          check_in
          check_out
          check_in_latitude
          check_in_longitude
          check_out_latitude
          check_out_longitude
          check_in_photo_url
          check_out_photo_url
        }
        description
        create_date
        res_id
      }
    }
  ''';

  String get mutationActivityPipelinePaging => '''
    mutation Method { 
      methodMailActivity: MailActivity( 
        method_name: "search_read", 
        method_parameters: { 
          domain: [["res_model","=","crm.lead"]],
          order: "create_date desc",
          fields: [
            "id",
            "res_id",
            "res_name",
            "activity_type_id",
            "summary",
            "date_deadline",
            "calendar_event_id",
            "create_date"
          ]
        }
      )
    }
  ''';

  String mutationActivityPipelineBasedPipeline(String pipelineId) => '''
    mutation Method { 
      methodMailActivity: MailActivity( 
        method_name: "search_read", 
        method_parameters: { 
          domain: [["res_model","=","crm.lead"],["res_id","=", $pipelineId]],
          order: "create_date desc",
          fields: [ 
            "id",
            "res_id",
            "res_name",
            "activity_type_id",
            "summary",
            "date_deadline",
            "calendar_event_id",
            "create_date"
          ]
        }
      )
    }
  ''';

  String get mutationActivityCreationLeadModel => '''
    mutation Method { 
      methodIrModel: IrModel( 
        method_name: "search_read", 
        method_parameters: { 
          domain: [["model","=","crm.lead"]],
          fields: ["id","name"]
        }
      )
    }
  ''';

  String mutationAddDynamicActivityPipeline({
    required String pipelineId,
    required String activityCategoryId,
    required String name,
    required String description,
    required DateTime dateDeadline,
    required String userId,
    required String activityCreationLeadModelId
  }) => '''
    mutation Create {
      createMailActivity: MailActivity(
        MailActivityValues: {
          res_model: "crm.lead",
          res_id: $pipelineId,
          activity_type_id: $activityCategoryId,
          summary: "$name",
          note: "$description",
          date_deadline: "${DateHelper.standardDateFormat3.format(dateDeadline)}",
          user_id: $userId,
          res_model_id: $activityCreationLeadModelId
        }
      ) {
        id
        summary
      }
    }
  ''';

  String mutationAddMeetingActivityPipeline({
    required String pipelineId,
    required String activityCategoryId,
    required String name,
    required String description,
    required String userId,
    required String activityCreationLeadModelId,
    required String calendarEventId
  }) => '''
    mutation Create {
      createMailActivity: MailActivity(
        MailActivityValues: {
          res_model: "crm.lead",
          res_id: $pipelineId,
          activity_type_id: $activityCategoryId,
          summary: "$name",
          note: "$description",
          user_id: $userId,
          res_model_id: $activityCreationLeadModelId,
          calendar_event_id: $calendarEventId
        }
      ) {
        id
        summary
      }
    }
  ''';

  String mutationAddCalendarEventBeforeAddActivityPipeline({
    required String pipelineId,
    required String activityCategoryId,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String userId,
    required String activityCreationLeadModelId,
    required String locationUrl,
    required String location
  }) => '''
    mutation Create {
      createCalendarEvent: CalendarEvent(
        CalendarEventValues: {
          name: "$name",
          allday: false,
          start: "${DateHelper.standardDateFormat.format(startDate)}",
          stop: "${DateHelper.standardDateFormat.format(endDate)}",
          location: "$location",
          videocall_location: "$locationUrl",
          user_id: $userId,
          res_id: $pipelineId,
          res_model_id: $activityCreationLeadModelId
          res_model: "crm.lead",
          description: "$description"
        }
      ) {
        id
        name
      }
    }
  ''';

  String mutationDoneActivityPipeline(String activityPipelineId) => '''
    mutation Method {
      methodMailActivity: MailActivity(
        id: $activityPipelineId,
        method_name: "action_done",
        method_parameters: {}
      )
    }
  ''';

  String mutationDoneActivityPipelineWithFeedback({
    required String activityPipelineId,
    required String feedback
  }) => '''
    mutation Method {
      methodMailActivity: MailActivity(
        id: $activityPipelineId, 
        method_name: "_action_done",
        method_parameters: {
          feedback: "$feedback"
        }
      )
    }
  ''';

  String queryGettingPipelineIdBasedActivityPipelineId({
    required String activityPipelineId,
  }) => '''
    query MyQuery {
      MailActivity(id:$activityPipelineId) {
        id
        res_model
        res_id
        summary
      }
    }
  ''';

  String mutationUndoneActivityPipeline(String activityPipelineId) => '''
    mutation Method {
      methodMailActivity: MailActivity(
        id: $activityPipelineId,
        method_name: "unlink",
        method_parameters: {}
      )
    }
  ''';

  String get mutationActivityCategory => '''
    mutation Method { 
      methodMailActivityType: MailActivityType( 
        method_name: "search_read", 
        method_parameters: { 
          domain: [],
          fields: ["id","name","category"]
        } 
      )
    }
  ''';

  String mutationLostPaging({
    required String userId,
    required ShortLostType shortLostType
  }) {
    String type = () {
      if (shortLostType == ShortLostType.leads) {
        return "lead";
      } else if (shortLostType == ShortLostType.pipeline) {
        return "opportunity";
      }
      return "";
    }();
    String query = '''
      mutation Method {
        methodCrmLead: CrmLead(
          method_name: "search_read",
          method_parameters: {
            domain: [["type","=","$type"],["user_id.id","=",$userId],["active","=",false]],
            fields: ["id","name",,"priority","partner_name","contact_name","create_date","lost_reason_id"]
          },
        )
      }
    ''';
    return query;
  }

  String get queryQuotationCategory => '''
    query MyQuery {
      CrmStage {
        id
        name
      }
    }
  ''';

  String queryQuotationPaging(String userId) => '''
    query MyQuery {
      SaleOrder(
        order: "create_date desc",
        domain: [["user_id.id", "=", $userId]],
        limit: 999999999999999
      ) {
        id
        name
        state
        date_order
        amount_total
        user_id {
          id
          name
        }
        partner_id {
          id
          name
        }
      }
    }
  ''';

  String queryQuotationPagingBasedCustomer({
    required String userId,
    required String customerId
  }) => '''
    query MyQuery {
      SaleOrder(
        domain: [["partner_id.id","=",$customerId],["user_id.id","=",$userId]],
        limit: 999999999999999
      ) {
        id
        name
        state
        date_order
        amount_total
        user_id {
          id
          name
        }
        partner_id {
          id
          name
        }
      }
    }
  ''';

  String queryQuotationPagingBasedPipeline({
    required String userId,
    required String pipelineId
  }) => '''
    query MyQuery {
      SaleOrder(
        domain: [["opportunity_id.id","=",$pipelineId],["user_id.id","=",$userId]],
        limit: 999999999999999
      ) {
        id
        name
        state
        date_order
        amount_total
        user_id {
          id
          name
        }
        partner_id {
          id
          name
        }
      }
    }
  ''';

  String mutationQuotationDetail(String quotationId) => '''
    query MyQuery {
      SaleOrder(
        domain: [["id", "=", $quotationId]],
        limit: 999999999999999
      ) {
        id
        name
        state
        date_order
        partner_id{
          id
          name
        }
        opportunity_id {
          id
          name
        }
        pricelist_id{
          id
          name
        }
        payment_term_id {
          id
          name
        }
        partner_invoice_id{
          id
          name
          street
          street2
          city
          state_id{
            id
            name
          }
          zip
          country_id{
            id
            name
          }
        }
        partner_shipping_id{
          id
          name
          street
          street2
          city
          state_id{
            id
            name
          }
          zip
          country_id{
            id
            name
          }
        }
      }
    }
  ''';

  String queryQuotationDetailProductList(String quotationId) => '''
    query MyQuery {
      SaleOrder(
        domain: [["id", "=", $quotationId]],
        limit: 999999999999999
      ) {
        id
        name
        state
        user_id {
          id
          name
        }
        order_line {
          id
          product_id {
            id
            name
            uom_id {
              id
              name
            }
          }
          product_uom_qty
          price_unit
          price_subtotal
        }
        amount_total
      }
    }
  ''';

  String mutationQuotationDetailProductTotalPrice(String quotationId) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId
        method_name: "read",
        method_parameters: {
          fields: ["id", "name", "amount_total"]
        }
      )
    }
  ''';

  String mutationAddQuotationSeparately({
    required String partnerId,
    required String opportunityId,
    required DateTime validityDate,
    required String pricelistId,
    required String paymentTermId,
  }) {
    return '''
      mutation Create {
        createSaleOrder: SaleOrder(
          SaleOrderValues: {
            partner_id: $partnerId,
            ${() {
              if (opportunityId.isNotEmptyString) {
                return "opportunity_id: $opportunityId,";
              } else {
                return "";
              }
            }()}
            validity_date: "${DateHelper.standardDateFormat3.format(validityDate)}",
            pricelist_id: $pricelistId,
            payment_term_id: $paymentTermId,
          }
        ) {
          id
          name
          validity_date
        }
      }
    ''';
  }

  String mutationAddQuotationSaleOrderSeparately({
    required String orderId,
    required ShortQuotationProduct shortQuotationProduct
  }) {
    // tax_id: ${shortQuotationProduct.taxId},
    // product_packaging_id: ${shortQuotationProduct.productPackagingId}
    return '''
      mutation Create{
        createSaleOrderLine: SaleOrderLine(
          SaleOrderLineValues: {
            order_id: $orderId
            product_id: ${shortQuotationProduct.productId},
            product_uom_qty: ${shortQuotationProduct.qty},
            price_unit: ${shortQuotationProduct.unitPrice},
          }
        ) {
          id
          product_id{
            id
            name
          }
          product_uom_qty
          price_unit
        }
      }
    ''';
  }

  String mutationEditQuotationSeparately({
    required String id,
    required String partnerId,
    required String opportunityId,
    required DateTime validityDate,
    required String pricelistId,
    required String paymentTermId,
  }) {
    return '''
      mutation Update {
        updateSaleOrder: SaleOrder(
          id: $id,
          SaleOrderValues: {
            partner_id: $partnerId,
            ${() {
              if (opportunityId.isNotEmptyString) {
                return "opportunity_id: $opportunityId,";
              } else {
                return "";
              }
            }()}
            validity_date: "${DateHelper.standardDateFormat3.format(validityDate)}",
            pricelist_id: $pricelistId,
            payment_term_id: $paymentTermId,
          }
        ) {
          id
          name
          validity_date
        }
      }
    ''';
  }

  String mutationEditQuotationSaleOrderSeparately({
    required String id,
    required ShortQuotationProduct shortQuotationProduct
  }) {
    // tax_id: ${shortQuotationProduct.taxId},
    // product_packaging_id: ${shortQuotationProduct.productPackagingId}
    return '''
      mutation Update {
        updateSaleOrderLine: SaleOrderLine(
          id: $id,
          SaleOrderLineValues: {
            product_id: ${shortQuotationProduct.productId},
            product_uom_qty: ${shortQuotationProduct.qty},
            price_unit: ${shortQuotationProduct.unitPrice},
          }
        ) {
          id
          product_id{
            id
            name
          }
          product_uom_qty
          price_unit
        }
      }
    ''';
  }

  String mutationAddQuotation({
    required String partnerId,
    required DateTime validityDate,
    required String pricelistId,
    required String paymentTermId,
    required List<ShortQuotationProduct> shortQuotationProductList
  }) {
    List<String> orderLineQuery = shortQuotationProductList.map<String>(
      (shortQuotationProduct) {
        return '''
          [0, 0, {
            product_id: ${shortQuotationProduct.productId},
            product_uom_qty: ${shortQuotationProduct.qty},
            price_unit: ${shortQuotationProduct.unitPrice},
            tax_id: [${shortQuotationProduct.taxId}],
            product_packaging_id: ${shortQuotationProduct.productPackagingId}
          }],
        ''';
      }
    ).toList();
    return '''
      mutation Create {
        createSaleOrder: SaleOrder(
          SaleOrderValues: {
            partner_id: $partnerId,
            validity_date: "${DateHelper.standardDateFormat3.format(validityDate)}",
            pricelist_id: $pricelistId,
            payment_term_id: $paymentTermId,
            order_line:[
              ${() {
                String result = "";
                for (var orderLine in orderLineQuery) {
                  result += orderLine;
                }
                return result;
              }()}
            ]
          }
        ) {
          id
          name
          validity_date
          order_line{
            id
            product_id{
              id
              name
            }
            product_uom_qty
            price_subtotal
          }
        }
      }
    ''';
  }

  String mutationEditQuotation({
    required String id,
    required String partnerId,
    required DateTime validityDate,
    required String pricelistId,
    required String paymentTermId,
    required List<ShortQuotationProduct> shortQuotationProductList
  }) {
    List<String> orderLineQuery = shortQuotationProductList.map<String>(
      (shortQuotationProduct) {
        return '''
          [0, 0, {
            product_id: ${shortQuotationProduct.productId},
            product_uom_qty: ${shortQuotationProduct.qty},
            price_unit: ${shortQuotationProduct.unitPrice},
            tax_id: [${shortQuotationProduct.taxId}],
            product_packaging_id: ${shortQuotationProduct.productPackagingId}
          }],
        ''';
      }
    ).toList();
    return '''
      mutation Update {
        updateSaleOrder: SaleOrder(
          id: $id,
          SaleOrderValues: {
            partner_id: $partnerId,
            validity_date: "${DateHelper.standardDateFormat3.format(validityDate)}",
            pricelist_id: $pricelistId,
            payment_term_id: $paymentTermId,
            order_line:[
              ${() {
                String result = "";
                for (var orderLine in orderLineQuery) {
                  result += orderLine;
                }
                return result;
              }()}
            ]
          }
        ) {
          id
          name
          validity_date
          order_line{
            id
            product_id{
              id
              name
            }
            product_uom_qty
            price_subtotal
          }
        }
      }
    ''';
  }

  String get mutationProductPaging => '''
    mutation Method {
      methodProductProduct: ProductProduct(
        method_name: "search_read",
        method_parameters: {
          domain:[]
          fields:["id","name","description","uom_id","list_price"]
        }
      )
    }
  ''';

  String mutationProductDetail(String productId) => '''
    mutation Method {
      methodProductProduct: ProductProduct(
        method_name: "search_read",
        method_parameters: {
          domain:[["id", "=", $productId]
          fields:["id","name","description","uom_id","list_price"]
        }
      )
    }
  ''';

  String get mutationProductTaxesPaging => '''
    mutation Method {
      methodAccountTax: AccountTax(
        method_name: "search_read",
        method_parameters: {
          domain:[]
          fields:["id","name","amount"]
        }
      )
    }
  ''';

  String get mutationProductPackagingPaging => '''
    mutation Method {
      methodAccountTax: ProductPackaging(
        method_name: "search_read",
        method_parameters: {
          domain:[]
          fields:["id","name"]
        }
      )
    }
  ''';

  String mutationAddProduct({
    required String name,
    required String description,
    required String uomId,
    required int listPrice
  }) => '''
    mutation Create {
      createProductProduct: ProductProduct(
        ProductProductValues: {
          name: "$name",
          description: "$description",
          uom_id: $uomId,
          list_price: ${listPrice.toString()}
        }
      ) {
        id
        name
        uom_id {
          id
          name
        }
        list_price
      }
    }
  ''';

  String queryDetailAmountQuotationProduct(String quotationId) => '''
    query MyQuery {
      SaleOrder(
        domain: [["id", "=", $quotationId]],
        limit: 999999999999999
      ) {
        id
        name
        amount_untaxed
        amount_tax
        amount_total
        reward_amount
      }
    }
  ''';

  String mutationQuotationCountBasedCustomer(String customerId) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        method_name: "search_count",
        method_parameters: {
          domain:[["partner_id.id", "=", $customerId]]
        }
      )
    }
  ''';

  String mutationQuotationConfirm(String quotationId) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId, 
        method_name: "action_confirm",
        method_parameters: {}
      )
    }
  ''';

  String mutationQuotationCancel(String quotationId) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId, 
        method_name: "action_cancel",
        method_parameters: {}
      )
    }
  ''';

  String mutationQuotationReset(String quotationId) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId, 
        method_name: "action_draft",
        method_parameters: {}
      )
    }
  ''';

  String mutationCustomerPaging(CustomerType customerType, {String? userId}) => '''
    mutation Method {
      methodResPartner: ResPartner(
        method_name: "search_read",
        method_parameters: {
          domain:[
            ${userId.isNotEmptyString ? "[\"user_id.id\", \"=\", $userId]," : ""}
            ${customerType != CustomerType.all ? "[\"is_company\",\"=\",${customerType == CustomerType.company ? "True" : "False"}]" : ""}
          ]
          fields:["id","company_type","vat","name","email","phone","mobile","website","function","street","street2","city","state_id","zip","country_id"]
          order: "create_date desc"
        }
      )
    }
  ''';

  String mutationCustomerDetail(String customerId) => '''
    mutation Method {
      methodResPartner: ResPartner(
        method_name: "search_read",
        method_parameters: {
          domain:[["id","=",$customerId]]
          fields:["id","company_type","name","vat","email", "phone","mobile","website","function","street","street2","city","state_id","zip","country_id","user_id"]
        }
      )
    }
  ''';

  String get mutationCustomerPricelistPaging => '''
    mutation Method {
      methodProductPricelist: ProductPricelist(
        method_name: "search_read",
        method_parameters: {
          domain:[],
          fields:["id","name"]
        }
      )
    }
  ''';

  String get queryCustomerPaymentTermPaging => '''
    query MyQuery {
      AccountPaymentTerm(
        domain: []
      ) {
        id
        name
      }
    }
  ''';

  String mutationAddCustomer({
    required String name,
    required String vat,
    required String email,
    required String phone,
    required String mobile,
    required String street,
    required String street2,
    required String city,
    required String stateId,
    required String zip,
    required String countryId,
    required String website,
    required String jobPosition,
    required CustomerType customerType,
    required String userId,
  }) {
    String state = "";
    if (stateId.isNotEmptyString) {
      state = "state_id: $stateId";
    }
    String country = "";
    if (countryId.isNotEmptyString) {
      country = "country_id: $countryId";
    }
    String function = "";
    if (jobPosition.isNotEmptyString) {
      function = "function: \"$jobPosition\"";
    }
    return '''
      mutation Create {
        createResPartner: ResPartner(
          ResPartnerValues: {
            name: "$name",
            vat: "$vat",
            email: "$email",
            phone: "$phone",
            mobile: "$mobile",
            street: "$street",
            street2: "$street2",
            city: "$city",
            zip: "$zip",
            ${state.isNotEmptyString ? "$state," : ""}
            ${country.isNotEmptyString ? "$country," : ""}
            ${function.isNotEmptyString ? "$function," : ""}
            website: "$website",
            company_type: "${() {
              if (customerType == CustomerType.company) {
                return "company";
              } else if (customerType == CustomerType.individual) {
                return "person";
              } else {
                return "";
              }
            }()}",
            user_id: $userId
          }
        ) {
          id
          name
          company_type
        }
      }
    ''';
  }

  String mutationEditCustomer({
    required String customerId,
    required String name,
    required String vat,
    required String email,
    required String phone,
    required String mobile,
    required String street,
    required String street2,
    required String city,
    required String stateId,
    required String zip,
    required String countryId,
    required String website,
    required String jobPosition,
    required CustomerType customerType,
    required String userId
  }) {
    String state = "";
    if (stateId.isNotEmptyString) {
      state = "state_id: $stateId";
    }
    String country = "";
    if (countryId.isNotEmptyString) {
      country = "country_id: $countryId";
    }
    String function = "";
    if (jobPosition.isNotEmptyString) {
      function = "function: \"$jobPosition\"";
    }
    return '''
      mutation Update {
        methodResPartner: ResPartner(
          id: $customerId,
          ResPartnerValues: {
            name: "$name",
            vat: "$vat",
            email: "$email",
            phone: "$phone",
            mobile: "$mobile",
            street: "$street",
            street2: "$street2",
            city: "$city",
            zip: "$zip",
            ${state.isNotEmptyString ? "$state," : ""}
            ${country.isNotEmptyString ? "$country," : ""}
            ${function.isNotEmptyString ? "$function," : ""}
            website: "$website",
            company_type: "${() {
              if (customerType == CustomerType.company) {
                return "company";
              } else if (customerType == CustomerType.individual) {
                return "person";
              } else {
                return "";
              }
            }()}",
            user_id: $userId
          }
        ) {
          id
          name
        }
      }
    ''';
  }

  String get queryUomList => '''
    query MyQuery{
      UomUom{
        id
        name
        category_id{
          id
          name
        }
      }
    }
  ''';

  String mutationCustomerAdditionalAddressCount(String customerId) => '''
    mutation Method {
      methodResPartner: ResPartner(
        method_name: "search_count",
        method_parameters: {
          domain:[["parent_id.id", "=", $customerId]]
        }
      )
    }
  ''';

  String mutationCustomerAdditionalAddressBasedCustomer(String customerId) => '''
    mutation Method {
      methodResPartner: ResPartner(
        method_name: "search_read",
        method_parameters: {
          domain:[["parent_id.id", "=", $customerId]],
          fields: ["id","name","type","email","phone","mobile","street","street2","city","zip","state_id","country_id","website","comment"]
        }
      )
    }
  ''';

  String mutationCustomerAdditionalAddressBasedCustomerAdditionalAddressId(String customerAdditionalAddressId) => '''
    mutation Method {
      methodResPartner: ResPartner(
        method_name: "search_read",
        method_parameters: {
          domain:[["id", "=", $customerAdditionalAddressId]],
          fields: ["id","name","type","email","phone","mobile","street","street2","city","zip","state_id","country_id","website","comment"]
        }
      )
    }
  ''';

  String mutationAddCustomerAdditionalAddress({
    required String customerId,
    required String type,
    required String name,
    required String email,
    required String phone,
    required String mobile,
    required String street,
    required String street2,
    required String city,
    required String stateId,
    required String zip,
    required String countryId,
    required String comment,
  }) => '''
    mutation Create {
      createResPartner: ResPartner(
        ResPartnerValues: {
          type: "$type",
          name: "$name",
          email: "$email",
          phone: "$phone",
          mobile: "$mobile",
          street: "$street",
          street2: "$street2",
          city: "$city",
          state_id: $stateId,
          zip: "$zip",
          country_id: $countryId,
          comment: "$comment"
          parent_id: $customerId
        }
      ) {
        id
        name
      }
    }
  ''';

  String mutationEditCustomerAdditionalAddress({
    required String id,
    required String type,
    required String name,
    required String email,
    required String phone,
    required String mobile,
    required String street,
    required String street2,
    required String city,
    required String stateId,
    required String zip,
    required String countryId,
    required String comment,
  }) => '''
    mutation Update {
      methodResPartner: ResPartner(
        id: $id,
        ResPartnerValues: {
          type: "$type",
          name: "$name",
          email: "$email",
          phone: "$phone",
          mobile: "$mobile",
          street: "$street",
          street2: "$street2",
          city: "$city",
          state_id: $stateId,
          zip: "$zip",
          country_id: $countryId,
          comment: "$comment"
        }
      ) {
        id
        name
      }
    }
  ''';

  String get mutationAddressType => '''
    mutation Method {
      methodIrModelFields: IrModelFields(
        method_name: "search_read",
        method_parameters: {
          domain:[["model", "=", "res.partner"], ["name", "=", "type"]],
          fields: ["selection"]
        }
      ) 
    }
  ''';

  String queryActivityCalendar(String userId) => '''
    query MyQuery{
      CalendarEvent(
        domain: [["user_id.id","=",$userId],["res_model", "=", "crm.lead"]],
        limit: 999999999999999
      ){
        id
        name
        start
        stop
        location
        videocall_location
        attendance_id {
          id
          activity_state
          check_in
          check_out
          check_in_latitude
          check_in_longitude
          check_out_latitude
          check_out_longitude
          check_in_photo_url
          check_out_photo_url
        }
        description
      }
    }
  ''';

  String queryActivityCalendarDetail(String activityCalendarId) => '''
    query MyQuery{
      CalendarEvent(id: $activityCalendarId){
        id
        name
        start
        stop
        location
        videocall_location
        description
      }
    }
  ''';

  String mutationActivityCountBasedPipeline(String pipelineId) => '''
    mutation Method { 
      methodMailActivity: MailActivity( 
        method_name: "search_count", 
        method_parameters: { 
          domain: [["res_model","=","crm.lead"],["res_id","=", $pipelineId]],
        }
      )
    }
  ''';

  String mutationAddActivity({
    required String name,
    required DateTime startDate,
    required DateTime stopDate,
    required String location,
    required String meetingUrl,
    required String userId,
    required String activityCreationLeadModelId,
    required String description
  }) => '''
    mutation Create {
      createCalendarEvent: CalendarEvent(
        CalendarEventValues: {
          name: "$name",
          allday: false,
          start: "${DateHelper.standardDateFormat.format(startDate)}",
          stop: "${DateHelper.standardDateFormat.format(stopDate)}",
          location: "$location",
          videocall_location: "$meetingUrl",
          user_id: $userId,
          res_model_id: $activityCreationLeadModelId
          res_model: "crm.lead",
          description: "$description"
        }
      ) {
        id
        name
      }
    }
  ''';

  String mutationDeleteActivity({
    required String activityId
  }) => '''
    mutation Delete {
      deleteCalendarEvent: CalendarEvent(
        id: $activityId, 
      )
    }
  ''';

  String mutationEditActivity({
    required String id,
    required String name,
    required String start,
    required String stop,
    required String location,
    required String meetingUrl,
    required String description
  }) => '''
    mutation Update {
      updateCalendarEvent: CalendarEvent(
        id: $id,
        CalendarEventValues: {
          name: "$name",
          allday: false,
          start: "$start",
          stop: "$stop",
          location: "$location",
          videocall_location: "$meetingUrl",
          description: "$description"
        }
      ) {
        id
        name
      }
    }
  ''';

  String mutationQuotationCountBasedPipeline(String pipelineId) => '''
    mutation Method { 
      methodSaleOrder: SaleOrder( 
        method_name: "search_count", 
        method_parameters: { 
          domain: [["opportunity_id.id","=",$pipelineId]],
        }
      )
    }
  ''';

  String get mutationCustomerTitle => '''
    query MyQuery {
      ResPartnerTitle {
        id
        name
      }
    }
  ''';

  String get queryCountryList => '''
    query MyQuery {
      CrmCountry {
        id
        name
      }
    }
  ''';

  String get queryStateList => '''
    query MyQuery {
      CrmState {
        id
        name
      }
    }
  ''';

  String mutationCheckIn({
    required double checkInLatitude,
    required double checkInLongitude,
    required String checkInIpAddress,
    required String employeeId,
    required String imageUrl,
    required DateTime checkInTime,
  }) => '''
    mutation Create {
      createHrAttendance: HrAttendance(
        HrAttendanceValues: {
          check_in_latitude: $checkInLatitude,
          check_in_longitude: $checkInLongitude,
          check_in_ipaddress: "$checkInIpAddress",
          employee_id: $employeeId,
          check_in_photo_url: "$imageUrl",
          check_in: "${DateHelper.standardDateFormat.format(checkInTime)}"
        }
      ) {
        id
      }
    }
  ''';

  String mutationStoreCheckInIdInCalendarActivity({
    required String activityId,
    required String attendanceId,
  }) => '''
    mutation Update {
      updateCalendarEvent: CalendarEvent(
        id: $activityId,
        CalendarEventValues: {
          attendance_id: $attendanceId,
        }
      ) {
        id
        name
        attendance_id {
          id
          activity_state
          check_in
          check_out
          check_in_latitude
          check_in_longitude
          check_out_latitude
          check_out_longitude
          check_in_photo_url
          check_out_photo_url
        }
      }
    }
  ''';

  String mutationCheckOut({
    required String attendanceId,
    required double checkOutLatitude,
    required double checkOutLongitude,
    required String checkOutIpAddress,
    required String employeeId,
    required String imageUrl,
    required DateTime checkOutTime,
  }) => '''
    mutation Update {
      updateHrAttendance: HrAttendance(
        id: $attendanceId,
        HrAttendanceValues: {
          check_out_latitude: $checkOutLatitude,
          check_out_longitude: $checkOutLongitude,
          check_out_ipaddress: "$checkOutIpAddress",
          employee_id: $employeeId,
          check_out_photo_url: "$imageUrl"
          check_out: "${DateHelper.standardDateFormat.format(checkOutTime)}"
        }
      ) {
        id
      }
    }
  ''';

  String mutationUpdateActivityCheckInOutState({
    required String attendanceId
  }) => '''
    mutation Method {
      methodHrAttendance: HrAttendance(
        id: $attendanceId, 
        method_name: "compute_activity_state",
        method_parameters: {}
      )
    }
  ''';

  String queryCalendarActivityAttendanceList({
    required int userId
  }) => '''
    query MyQuery{
      CalendarEvent(domain: [["user_id.id","=",$userId],["res_model", "=", "crm.lead"]]){
        id
        name
        start
        stop
        attendance_id{
          id
          activity_state
          check_in
          check_out
          check_in_latitude
          check_in_longitude
          check_out_latitude
          check_out_longitude
          check_in_photo_url
          check_out_photo_url
        }
      }
    }
  ''';

  String mutationEmployeeBasedUserId(String userId) => '''
    mutation Method { 
      methodHrEmployee: HrEmployee( 
        method_name: "search_read", 
        method_parameters: {
          domain: [["user_id.id","=",$userId]],
          fields: ["id","name","job_id"]
        } 
      )
    }
  ''';

  String queryAchievementPercentageAndTargetPoint(String userId) => '''
    query MyQuery {
      SalesTarget(domain:[["user_id.id", "=", $userId]]) {
        id
        user_id{
          id
          name
        }
        achievement_percentage
        target_point
        target_amt
        state
        start_date
        end_date
      }
    }
  ''';

  String mutationApplyVoucher({
    required String quotationId,
    required String voucherCode
  }) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId, 
        method_name: "get_available_coupon_rewards",
        method_parameters: {
          code: "$voucherCode"
        }
      )
    }
  ''';

  String mutationSelectAvailableRewards({
    required String quotationId,
    required String rewardId,
    required String voucherCode
  }) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId, 
        method_name: "apply_coupon_rewards",
        method_parameters: {
          reward: $rewardId,
          code: "$voucherCode",
        }
      )
    }
  ''';

  String mutationUpdateQuotationDataAfterApplyVoucher({
    required String quotationId
  }) => '''
    mutation Method {
      methodSaleOrder: SaleOrder(
        id: $quotationId, 
        method_name: "_update_programs_and_rewards",
        method_parameters: {}
      )
    }
  ''';

  String queryRecommendationActivityPipelineTypeList({
    required String lastActivityPipelineTypeId
  }) => '''
    query MyQuery{
      MailActivityType(id: $lastActivityPipelineTypeId){
        suggested_next_type_ids{
          id
          name
          category
        }
      }
    }
  ''';
}