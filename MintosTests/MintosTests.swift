//
//  MintosTests.swift
//  MintosTests
//
//  Created by Mohamed anwar on 30/08/2023.
//

import XCTest

import XCTest
import CombineTestExtensions
@testable import Mintos

final class MintosTests: XCTestCase {

    private var paymentDetailsRepository: PaymentDetailsRepositoryStub!
    private var viewModel: PaymentDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        paymentDetailsRepository = .init()
        viewModel = PaymentDetailsViewModel(paymentDetailsRepository: paymentDetailsRepository)
    }
    
    override func tearDown() {
        paymentDetailsRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchPaymentDetailsSuccess() {
        //GIVEN
        let viewStateRecorder = viewModel.output.$viewState.record(numberOfRecords: 3)
        let paymentDetailsRecorder = viewModel.output.$dataSource.record(numberOfRecords: 2)
        
        let paymentDetails: PaymentDetails = .init(
            paymentDetails: "Investor ID: 54361338",
            items: [
                .init(
                    bank: "Bank",
                    swift: "swift",
                    currency: "currency",
                    beneficiaryName: "beneficiaryName",
                    beneficiaryBankAddress: "beneficiaryBankAddress",
                    iban: "iban"
                )
            ]
        )
        
        
        paymentDetailsRepository.paymentDetails = paymentDetails
        
        //WHEN
        viewModel.input.viewDidLoadTrigger.send()
        let viewStateRecords = viewStateRecorder.waitAndCollectRecords()
        let paymentDetailsRecords = paymentDetailsRecorder.waitAndCollectRecords()
        
        //THEN
        XCTAssertEqual(viewStateRecords, [
            .value(nil),
            .value(.loading(isUserInteractionEnabled: true)),
            .value(.idle)
        ])
        
        XCTAssertEqual(paymentDetailsRecords, [
            .value(nil),
            .value(paymentDetails)
        ])

        
    }
    
    func testFetchPaymentDetailsFail() {
        //GIVEN
        let viewStateRecorder = viewModel.output.$viewState.record(numberOfRecords: 3)
        let errorRecorder = viewModel.output.$error.record(numberOfRecords: 2)
        let paymentDetailsRecorder = viewModel.output.$dataSource.record(numberOfRecords: 1)

        paymentDetailsRepository.paymentDetails = nil

        //WHEN
        viewModel.input.viewDidLoadTrigger.send()
        let viewStateRecords = viewStateRecorder.waitAndCollectRecords()
        let errorRecords = errorRecorder.waitAndCollectRecords()
        let paymentDetailsRecords = paymentDetailsRecorder.waitAndCollectRecords()

        //THEN
        XCTAssertEqual(viewStateRecords, [
            .value(nil),
            .value(.loading(isUserInteractionEnabled: true)),
            .value(.idle)
        ])
        
        XCTAssertEqual(errorRecords, [
            .value(nil),
            .value(ServiceError.noData.localizedDescription),

        ])
        
        XCTAssertEqual(paymentDetailsRecords, [
            .value(nil),
        ])

    }

}
