//
//  MockOrderModels.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/18/22.
//

import SwiftUI

enum StatusesEnum: String, CaseIterable, Identifiable, Codable  {
    var id: String { self.rawValue }
    case QUOTE
    case INQUIRY
    case NEEDS_FUNDING
    case AUTH_DEL_IN_PROGRESS
    case AUTH_IN_PROGRESS
    case CST_DECLINED
    case PRV_DECLINED
    case ACCEPTED
    case PRV_NEAR
    case ARRIVED
    case COMPLETED
    case VISIT_PRV_NEAR
    case VISIT_ARRIVED
    case VISIT_COMPLETED
    case VISIT_CANCELLED
    case VISIT_UNSATISFIED
    case VISIT_PAYMENT_IN_PROGRESS
    case VISIT_PAID
    case VISIT_APPROVED
    case VISIT_CALLOUT_2PAY
    case PAYMENT_IN_PROGRESS
    case PAYMENT_REFUSED
    case VISIT_PAYMENT_REFUSED
    case APPROVED
    case PAID
    case PRV_REVIEWED
    case CST_REVIEWED
    case CLOSED
    case CANCELLED
    case CST_CANCELLED
    case UNSATISFIED
    case IN_DISPUTE
    case CALLOUT_2PAY

    var colors: [String] {
        switch self {
            case .QUOTE:
                return ["FFFFFF","FFFFFF"]
            case .INQUIRY:
                return ["FFFFFF","FFFFFF"]
            case .NEEDS_FUNDING:
                return ["FEFFE6","F5FFB4"]
            case .AUTH_DEL_IN_PROGRESS:
                return ["FFF6EC","FFEBD5"]
            case .AUTH_IN_PROGRESS:
                return ["FFF6EC","FFEBD5"]
            case .CST_DECLINED:
                return ["FEE4E1","FFB3AB"]
            case .PRV_DECLINED:
                return ["FEE4E1","FFB3AB"]
            case .ACCEPTED:
                return ["D4F6E2","BAFFD7"]
            case .ARRIVED:
                return ["EEFDFF","DDF3F6"]
            case .PRV_NEAR:
                return ["EEFDFF","DDF3F6"]
            case .COMPLETED:
                return ["EEFDFF","DDF3F6"]
            case .VISIT_PRV_NEAR:
                return ["EEFDFF","DDF3F6"]
            case .VISIT_ARRIVED:
                return ["EEFDFF","DDF3F6"]
            case .VISIT_COMPLETED:
                return ["EEFDFF","DDF3F6"]
            case .VISIT_CANCELLED:
                return ["FEE4E1","FFB3AB"]
            case .VISIT_UNSATISFIED:
                return ["FEE4E1","FFB3AB"]
            case .VISIT_PAYMENT_IN_PROGRESS:
                return ["FFF6EC","FFEBD5"]
            case .VISIT_PAID:
                return ["D4F6E2","BAFFD7"]
            case .VISIT_APPROVED:
                return ["D4F6E2","BAFFD7"]
            case .VISIT_CALLOUT_2PAY:
                return ["FEE4E1","FFB3AB"]
            case .PAYMENT_IN_PROGRESS:
                return ["FFF6EC","FFEBD5"]
            case .PAYMENT_REFUSED:
                return ["FEE4E1","FFB3AB"]
            case .VISIT_PAYMENT_REFUSED:
                return ["FEE4E1","FFB3AB"]
            case .APPROVED:
                return ["D4F6E2","BAFFD7"]
            case .PAID:
                return ["D4F6E2","BAFFD7"]
            case .PRV_REVIEWED:
                return ["FFFFFF","DEE2E6"]
            case .CST_REVIEWED:
                return ["FFFFFF","DEE2E6"]
            case .CLOSED:
                return ["FFFFFF","DEE2E6"]
            case .CANCELLED:
                return ["FEE4E1","FFB3AB"]
            case .CST_CANCELLED:
                return ["FEE4E1","FFB3AB"]
            case .UNSATISFIED:
                return ["FEE4E1","FFB3AB"]
            case .IN_DISPUTE:
                return ["FEE4E1","FFB3AB"]
            case .CALLOUT_2PAY:
                return ["FEE4E1","FFB3AB"]
        }
    }


    var display: String {
        switch self {
            case .QUOTE:
                return "Quote"
            case .INQUIRY:
                return "Inquiry"
            case .NEEDS_FUNDING:
                return "Funds reservation is needed"
            case .AUTH_DEL_IN_PROGRESS:
                return "Auth deletion in progress"
            case .AUTH_IN_PROGRESS:
                return "Payment authorisation in progress"
            case .CST_DECLINED:
                return "Declined"
            case .PRV_DECLINED:
                return "Declined"
            case .ACCEPTED:
                return "Accepted"
            case .ARRIVED:
                return "Arrived"
            case .PRV_NEAR:
                return "Provider is near"
            case .COMPLETED:
                return "Completed"
            case .VISIT_PRV_NEAR:
                return "Provider is near on visit"
            case .VISIT_ARRIVED:
                return "Arrived on visit"
            case .VISIT_COMPLETED:
                return "Service completed"
            case .VISIT_CANCELLED:
                return "Visit cancelled"
            case .VISIT_UNSATISFIED:
                return "Unsatisfied with visit"
            case .VISIT_PAYMENT_IN_PROGRESS:
                return "Visit payment processing"
            case .VISIT_PAID:
                return "Visit paid"
            case .VISIT_APPROVED:
                return "Visit Approved"
            case .VISIT_CALLOUT_2PAY:
                return "Visit Callout Charge requested"
            case .PAYMENT_IN_PROGRESS:
                return "Payment processing"
            case .PAYMENT_REFUSED:
                return "Funds reservation failed"
            case .VISIT_PAYMENT_REFUSED:
                return "Visit payment capture failed"
            case .APPROVED:
                return "Approved"
            case .PAID:
                return "Paid"
            case .PRV_REVIEWED:
                return "Reviewed by provider"
            case .CST_REVIEWED:
                return "Reviewed by customer"
            case .CLOSED:
                return "Closed"
            case .CANCELLED:
                return "Cancelled"
            case .CST_CANCELLED:
                return "Cancelled by customer"
            case .UNSATISFIED:
                return "Unsatisfied"
            case .IN_DISPUTE:
                return "In dispute"
            case .CALLOUT_2PAY:
                return "Callout charge requested"
        }
    }
}
