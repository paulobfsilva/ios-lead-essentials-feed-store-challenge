//
//  ManagedCache.swift
//  FeedStoreChallenge
//
//  Created by Paulo Silva on 02/09/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
final class ManagedCache: NSManagedObject {
	@NSManaged var timestamp: Date
	@NSManaged var feed: NSOrderedSet
	var localFeed: [LocalFeedImage] {
		feed.compactMap { ($0 as? ManagedFeedImage)?.local }
	}

	static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
		try fetch(from: context).map(context.delete)
		return ManagedCache(context: context)
	}

	static func fetch(from context: NSManagedObjectContext) throws -> ManagedCache? {
		let request = NSFetchRequest<ManagedCache>(entityName: entity().name!)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}
}
